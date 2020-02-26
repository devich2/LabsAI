using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace CrossTask
{
    [Serializable]
    class Person: ICompatible<Person>, IEquatable<Person>
    {
        private string Name { get; }

        private bool isMan() => Name.StartsWith(manIdentifier);

        private static string manIdentifier = "m";

        public Person(string name)
        {
            Name = name;
        }

        public string Surname =>
            Regex.Matches(Name, @".(\d+)$")[0].Groups[1].Value;

        public bool isCompatible(List<Person> group)
        {
            var men = group.Where(x => x.isMan());
            var women = group.Except(men).ToList();
            if (men.Count() == 0) return true;

            return women.TrueForAll(wm => 
               men.Where(x => x.isCompatible(wm)).Count() != 0);
        }

        public bool isCompatible(Person other)=> 
            (isMan() == other.isMan()) || (Surname == other.Surname);

        public override string ToString()
        {
            return Name;
        }

        public bool Equals(Person other)
        {
            return Name == other.Name;
        }

    }
}
