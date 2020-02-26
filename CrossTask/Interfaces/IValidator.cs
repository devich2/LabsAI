using System;
using System.Collections.Generic;
using System.Text;

namespace CrossTask
{
    interface IValidator<T>
    {
        bool isValidGroup(List<T> group);
        bool isValidState(State<T> state);
    }
}
