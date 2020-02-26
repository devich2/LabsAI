using System;
using System.Collections.Generic;
using System.Text;

namespace CrossTask
{
    interface ICompatible<T>
    {
       bool isCompatible(List<T> group);
    }
}
