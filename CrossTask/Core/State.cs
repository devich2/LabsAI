using CrossTask.Helpers;
using CrossTask.Interfaces;
using System;
using System.Collections.Generic;

namespace CrossTask
{
    [Serializable]
    class State<T> : IEquatable<State<T>> where T: IEquatable<T>, ISizable
    {
        public List<T> elements;

        public int Cost;

        public T from;
        public T to;

        public State()
        {
            elements = new List<T>();
        }

        public State(List<T> elems)
        {
            elements = elems;
        }

        public T Find(T item)
        {
            return elements.Find(x => x.Equals(item));
        }

        public bool Equals(State<T> other) =>
            elements.TrueForAll(ves => other.elements.Contains(ves));

        public override string ToString()
        {
            return ((from != null && to != null) ? $"From {from.Capacity}-l to {to.Capacity}-l \tCost: {Cost}\n" : "") +
                $"Vessels: {string.Join("\t", elements)}\n";
        }
    }
   
}