using System;
using System.Collections.Generic;
using System.Text;

namespace CrossTask
{
    enum Location
    {
        Left,
        Right
    }

    struct Boat
    {
        public int capacity;
        public Location position;

        public Boat(int cp, Location pos)
        {
            capacity = cp;
            position = pos;
        }
    }
}
