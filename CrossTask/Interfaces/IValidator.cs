using System;
using System.Collections.Generic;
using System.Text;

namespace CrossTask
{
    interface IValidator<T>
    {
        bool isValidBoatGroup(List<T> group, List<List<T>> allowed);
        bool isValidBankGroup(List<T> group, List<List<T>> notAllowed);
    }
}
