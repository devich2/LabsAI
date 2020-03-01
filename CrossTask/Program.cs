using CrossTask.Core;
using CrossTask.Helpers;
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
            var initialElems = new List<Vessel>()
            {
                new Vessel(12,12),
                new Vessel(5,0),
                new Vessel(7,0)
            };

            var finalElems = new Dictionary<Vessel, int>();
            finalElems.Add(new Vessel(6), 2);

            State<Vessel> initial = new State<Vessel>(initialElems);

            Action<List<State<Vessel>>> actionPrint = list =>
            {
                Console.WriteLine("Decision");

                initialElems.ForEach(elem => Console.Write($"{elem.Capacity}-l\t\t\t"));
                Console.Write(Environment.NewLine);
                Console.Write(Environment.NewLine);

                int cost = 0;
                list.ForEach(state =>
                {
                    cost += state.Cost;
                    Console.WriteLine(state);
                });
                Console.WriteLine($"\nFINAL COST - {cost}");
                Console.WriteLine(new string('-', 10));
            };

            TransfuseSolver<Vessel> solver = new TransfuseSolver<Vessel>(finalElems);
            solver.Solve(initial, actionPrint);

            Console.ReadLine();
        }
    }
}
