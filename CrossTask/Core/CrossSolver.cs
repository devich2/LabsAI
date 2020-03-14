using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CrossTask
{
    class CrossSolver<T> where T : IEquatable<Passenger>
    {
        private IValidator<T> _validator;
        private Boat boat;
        private List<List<T>> _allowedInBoat;
        private List<List<T>> _notAllowedAlone;

        private List<int> _checkedSizeGroup;

        public CrossSolver(IValidator<T> checker, Boat bt)
        {
            _validator = checker;
            boat = bt;
        }

        public void SetRules(List<List<T>> allowedInBoat, List<List<T>> notAllowedAlone)
        {
            _allowedInBoat = allowedInBoat;
            _notAllowedAlone = notAllowedAlone;

            _checkedSizeGroup = new List<int>();

            foreach (var list in allowedInBoat)
            {
                _checkedSizeGroup.Add(list.Count());
            }
        }

        private List<State<T>> GenerateStates(State<T> state)
        {
            List<State<T>> _possStates = new List<State<T>>();
            List<T> _source = state[state._boatPos];

            Location _destinationLocation = state._boatPos == Location.Left ? Location.Right : Location.Left;

            for (int i = 0; i <= boat.capacity; i++)
            {
                if (i > _source.Count) break;
                var groups = Combinations.GetCombinations(_source, i);

                foreach (var group in groups)
                {
                    State<T> copy = null;

                    //Если проверяемая група вышла за размер непроверяемых
                    if ( _checkedSizeGroup.Contains(i) && !_validator.isValidBoatGroup(group, _allowedInBoat))
                         continue;
            
                    copy = Serializer.DeepCopy(state);
                    group.ForEach(el =>
                    {
                        copy[state._boatPos].Remove(el);
                        copy[_destinationLocation].Add(el);
                    });

                    if (_validator.isValidBankGroup(copy[state._boatPos], _notAllowedAlone))
                    {
                        copy._depth++;
                        copy._boatPos = _destinationLocation;
                        copy._step = $"Group : " +
                           $"{string.Join(", ", group.ToList())}, " +
                           $"from {state._boatPos} to {_destinationLocation}";

                        _possStates.Add(copy);
                    }
                }
            }
            return _possStates.Distinct().ToList();
        }

        private static List<State<T>> UnWrapList(State<T> state)
        {
            List<State<T>> result = new List<State<T>>();
            State<T> current = Serializer.DeepCopy(state);
            while (current != null)
            {
                result.Add(current);
                current = current._parentState;
            }
            return result.Reverse<State<T>>().ToList();
        }

        private void ReduceQueue(int beamWidth, Queue<State<T>> states)
        {
            var depthStates = states.
                OrderByDescending(x => x[Location.Right].Count()).Take(beamWidth).ToList();

            states.Clear();
            foreach (var state in depthStates)
            {
                states.Enqueue(state);
            }
        }

        private bool IsCurrentLevelEmpty(int depth, Queue<State<T>> states) =>
            states.Where(x => x._depth == depth).Count() == 0;

        public bool FindPath(State<T> initial, State<T> final, Action<List<State<T>>> action, int beamWidth)
        {
            Queue<State<T>> states = new Queue<State<T>>();
            List<State<T>> history = new List<State<T>>();

            states.Enqueue(initial);
            history.Add(initial);
            int currentDepth = 0;

            while (states.TryDequeue(out initial))
            {
                List<State<T>> gens = GenerateStates(initial).Where(x => !history.Contains(x)).ToList();
                history.AddRange(gens);
                gens.ForEach(gn =>
                {
                    Console.WriteLine(gn + "\t" + gn._depth);
                    gn._parentState = initial;
                    if (gn.Equals(final)) action(UnWrapList(gn));
                    states.Enqueue(gn);
                });

                if (IsCurrentLevelEmpty(currentDepth, states))
                {
                    currentDepth++;
                    ReduceQueue(beamWidth, states);
                }
            }
            return false;
        }
    }
}
