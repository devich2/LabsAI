using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Formatters.Binary;
using System.Text;

namespace CrossTask
{
    static class Extensions
    {
        public static string ToString(this Location location)
        {
            switch(location)
            {
                case Location.Left: return "left";
                case Location.Right: return "right";
                default: throw new ArgumentOutOfRangeException("location");
            }
        }
    }
    static class Serializer
    {
        public static T DeepCopy<T>(T item)
        {
            BinaryFormatter formatter = new BinaryFormatter();
            MemoryStream stream = new MemoryStream();
            formatter.Serialize(stream, item);
            stream.Position = 0;
            T result = (T)formatter.Deserialize(stream);
            stream.Close();
            return result;
        }
    }

    static class Combinations
    {
        private static IEnumerable<int[]> GetIndexCombination(int m, int n)
        {
            int[] result = new int[m];
            Stack<int> stack = new Stack<int>(m);
            stack.Push(0);
            while (stack.Count > 0)
            {
                int index = stack.Count - 1;
                int value = stack.Pop();
                while (value < n)
                {
                    result[index++] = value++;
                    stack.Push(value);
                    if (index != m) continue;
                    yield return (int[])result.Clone();
                    break;
                }
            }
        }

        public static IEnumerable<List<T>> GetCombinations<T>(List<T> array, int m)
        {
            if (array.Count < m)
                throw new ArgumentException("Array length can't be less than number of selected elements");
            if (m < 1)
                throw new ArgumentException("Number of selected elements can't be less than 1");
            T[] result = new T[m];
            foreach (int[] j in GetIndexCombination(m, array.Count))
            {
                for (int i = 0; i < m; i++)
                {
                    result[i] = array[j[i]];
                }
                yield return result.ToList();
            }
        }
    }
}
