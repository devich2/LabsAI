using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace CrossTask
{
    enum PassengerType
    {
        Goose,
        Lion,
        Fox,
        Maze
    }

    [Serializable]
    class Passenger: IEquatable<Passenger>
    {
        private string _name { get; }

        public Passenger(string name)
        {
            _name = name;
        }

        public override string ToString()
        {
            return _name;
        }

        public bool Equals(Passenger other)
        {
            return _name == other._name;
        }

    }
}
