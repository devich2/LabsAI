using System;
using System.Collections.Generic;

namespace CrossTask
{
    [Serializable]
    class State<T> : IEquatable<State<T>>
    {
        public Location _boatPos;
        private List<T> _left;
        private List<T> _right;
        public State<T> _parentState;
        public string _step;


        public List<T> this[Location loc]
        {
            get => loc == Location.Left ? _left : _right;
            set
            {
                var bank  = loc == Location.Left ? _left : _right;
                bank = value;
            }
        }

        public State(Location boatPos, List<T> leftBank, List<T> rightBank)
        {
            _boatPos = boatPos;
            _left = leftBank;
            _right = rightBank;
        }

        public bool Equals(State<T> other)
        {
            return EqualSequence(_left, other[Location.Left])
                && EqualSequence(_right, other[Location.Right])
                && (_boatPos == other._boatPos);
        }

        private bool EqualSequence(List<T> first, List<T> second)=>
            first.TrueForAll(x => second.Contains(x));
   
        public override string ToString()
        {
            return $"\n{(_step != null ? ("Step:" + _step) : string.Empty)} " +
                $"\nBoat pos: {_boatPos}------" +
                $"LeftBank: {((_left.Count > 0) ? (string.Join(",", _left)) : "empty")}-------" +
                $"RightBank: {((_right.Count > 0) ? (string.Join(",", _right)) : "empty")}";
        }
    }
}