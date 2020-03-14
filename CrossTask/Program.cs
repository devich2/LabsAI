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
;           StateValidator<Passenger> validator = new StateValidator<Passenger>();
            Boat boat = new Boat(2, Location.Left);
            CrossSolver<Passenger> solver = new CrossSolver<Passenger>(validator, boat);

            var emptyList = new List<Passenger>();
            var finalList = new List<Passenger>(){
                    new Passenger("lion"),
                    new Passenger("goose"),
                    new Passenger("maze"),
                    new Passenger("fox"),
            };


            var initial = new State<Passenger>(Location.Left, finalList, emptyList, 0);
            var final = new State<Passenger>(Location.Right, emptyList, finalList, 0);

            var allowedInBoat = new List<List<Passenger>>()
            {
                new List<Passenger>(){ new Passenger("goose"), new Passenger("maze") },
                new List<Passenger>(){ new Passenger("fox"), new Passenger("maze") },
            };

            var notAllowedAlone = new List<List<Passenger>>()
            {
                new List<Passenger>(){ new Passenger("maze"), new Passenger("goose") },
                new List<Passenger>(){ new Passenger("fox"), new Passenger("goose") },
                new List<Passenger>(){ new Passenger("fox"), new Passenger("lion") },
            };

            Action<List<State<Passenger>>> act =
                list =>
                {
                    Console.WriteLine("\n\n-------------Found decision----------------");
                    list.ForEach(state => Console.WriteLine(state));
                    Console.ReadLine();
                    Environment.Exit(0);
                };

            try
            {
                solver.SetRules(allowedInBoat, notAllowedAlone);
                int beamWidth = 0;
                while(!solver.FindPath(Serializer.DeepCopy(initial), Serializer.DeepCopy(final), act, beamWidth))
                {
                    Console.WriteLine($"Couldnt find with beam width - {beamWidth}");
                    beamWidth++;
                }
                
            }
            catch(NoDecisionException ex)
            {
                Console.WriteLine(ex.Message);
            }
            Console.ReadLine();

        }
    }
}
