using CrossTask.Interfaces;
using System;
using System.Collections.Generic;
using System.Text;

namespace CrossTask.Helpers
{
    [Serializable]
    class Vessel : ITransfusable<Vessel>, IEquatable<Vessel>, ISizable
    {
        private int _capacity;
        private int _size;

        public int Capacity
        {
            get => _capacity;
            set
            {
                if (_size > _capacity) throw new ArgumentOutOfRangeException("error");
                _capacity = value;
            }
        }

        public int Size
        {
            get => _size;
            set
            {
                if (value > _capacity) throw new ArgumentOutOfRangeException("error");
                _size = value;
            }
        }
        public Vessel(int cp, int s)
        {
            Capacity = cp;
            Size = s;
        }

        public Vessel(int s)
        {
            Capacity = s;
            Size = s;
        }

        public int Transfuse(Vessel other)
        {

            int max = Size;
            int allowed = other.Capacity - other.Size;
            int added = (max < allowed) ? max : allowed;
            other.Size += added;
            Size -= added;
            return added;
        }

        public bool isTransfusable(Vessel other) =>
            (Size != 0) && (other.Size != other.Capacity);


        public bool Equals(Vessel other) =>
            Capacity == other.Capacity && Size == other.Size;

        public override string ToString()
        {
            return $"{Size} liters";
        }
    }
}
