using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Formatters.Binary;

namespace CrossTask
{
    
    class Program
    {
        static void Main(string[] args)
        {
;           StateValidator<Person> validator = new StateValidator<Person>();
            Boat boat = new Boat(3, Location.Left);
            CrossSolver<Person> solver = new CrossSolver<Person>(validator, boat);

            var emptyList = new List<Person>();
            var finalList = new List<Person>(){
                    new Person("m1"),
                    new Person("m2"),
                    new Person("w1"),
                    new Person("w3"),
                    new Person("m3"),
                    new Person("w2"),
                   
            };


            var initial = new State<Person>(Location.Left, finalList, emptyList);
            var final = new State<Person>(Location.Right, emptyList, finalList);

            Action<List<State<Person>>> act =
                list =>
                {
                    Console.WriteLine("-------------Found decision----------------");
                    list.ForEach(state => Console.WriteLine(state));
                    Console.ReadLine();
                    Environment.Exit(0);
                };

            try
            {
                solver.FindPath(initial, final, act);
            }
            catch(NoDecisionException ex)
            {
                Console.WriteLine(ex.Message);
            }
            Console.ReadLine();

        }
    }
}
