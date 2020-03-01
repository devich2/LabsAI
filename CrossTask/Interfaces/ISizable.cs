using System;
using System.Collections.Generic;
using System.Text;

namespace CrossTask.Interfaces
{
    interface ISizable
    {
       int Capacity { get; set; }
       int Size { get; set; }
    }
}
