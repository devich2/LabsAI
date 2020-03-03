using CrossTask.Helpers;
using CrossTask.Interfaces;
using System;
using System.Collections.Generic;
using System.Text;
using System.Linq;

namespace CrossTask.Core
{
    class TransfuseSolver<T> where T: IEquatable<T>, ITransfusable<T>, ISizable
    {
        private Dictionary<T, int> _finalElems;

        public TransfuseSolver(Dictionary<T, int> result)
        {
            _finalElems = result;
        }

        private bool isFinal(State<T> other)
        {
            foreach(KeyValuePair<T, int> pair in _finalElems)
            {
                if (other.elements.Where(ves => ves.Size == pair.Key.Size).Count() < pair.Value) return false;
            }
            return true;
        }
           

        private void changeState(State<T> state, List<T> group)
        {
            var source = state.Find(group[0]);
            var destination = state.Find(group[1]);
            state.Cost = source.Transfuse(destination);
            state.from = group[0];
            state.to = group[1];
        }

        public List<State<T>> GenerateStates(State<T> state)
        {
            List<State<T>> _possStates = new List<State<T>>();

           var groups = Combinations.GetCombinations(state.elements, 2);
               foreach (var group in groups)
                {
                    State<T> copy = null;
                    if (group[0].isTransfusable(group[1]))
                    {
                      copy = Serializer.DeepCopy(state);
                      changeState(copy, group);
                      _possStates.Add(copy);
                    }
                }
            return _possStates;
        }

        private List<State<T>> UnWrapList(State<T> final, Dictionary<State<T>, State<T>> parents)
        {
                    List<State<T>> list = new List<State<T>>();
                    State<T> current = final;

                    while (parents.ContainsKey(current))
                    {
                        list.Add(current);
                        current = parents[current];
                    }
                    list.Reverse();
            return list;
        }

        public void Solve(State<T> initial, Action<List<State<T>>> action)
        {
            PriorityQueue<int, State<T>> openSet = new PriorityQueue<int, State<T>>();
            List<State<T>> closedSet = new List<State<T>>();

            Dictionary<State<T>, int> costs = new Dictionary<State<T>, int>();
            Dictionary<State<T>, State<T>> parents = new Dictionary<State<T>, State<T>>();

            openSet.Enqueue(0, initial);
            costs[initial] = 0;

            while (openSet.TryDequeue(out initial))
            {
                List<State<T>> generatedStates = GenerateStates(initial).ToList();
                int cost = costs[initial];
                foreach (var state in generatedStates)
                {
                    if (!closedSet.Contains(state)) openSet.Enqueue(state.Cost, state);
                    if (!costs.ContainsKey(state)) costs[state] = int.MaxValue;

                    int new_cost = cost + state.Cost;
                    
                    if (costs[state] > new_cost)
                    {
                        costs[state] = new_cost;
                        parents[state] = initial;
                    }
                }
                closedSet.Add(initial);
            }

            List<State<T>> finals = parents.Keys.Where(state => isFinal(state)).OrderBy(x=>costs[x]).ToList();
            if (finals.Count() == 0) throw new NoDecisionException("No decision!");
            else
            {
                finals.ForEach(finalState =>
                {
                    action(UnWrapList(finalState, parents));
                });
            }
        }

    }
}
