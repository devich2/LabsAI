using CrossTask.Helpers;
using System;
using System.Collections.Generic;
using System.Text;

namespace CrossTask.Interfaces
{
    interface ITransfusable<T>
    {
        bool isTransfusable(T ves);
        int Transfuse(T other);
    }
}
