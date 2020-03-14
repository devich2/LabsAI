using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CrossTask
{
    class StateValidator<T> : IValidator<T> where T : IEquatable<Passenger>
    {
        public bool isValidBankGroup(List<T> group, List<List<T>> notAllowed)
        {
            foreach (var list in notAllowed)
            {
                //Если в групе находятса все елементы даного запрещенного набора пасажиров
                if (list.TrueForAll(pass => group.Contains(pass))) return false;
            }
            return true;
        }

        public bool isValidBoatGroup(List<T> group, List<List<T>> allowed)
        {
            foreach (var list in allowed)
            {
                //Если даная група разрешена
                if (list.Count() == group.Count() && (list.TrueForAll(pass => group.Contains(pass)))) return true;
            }

            return false;
        }
    }
}
