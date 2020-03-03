using System;
using System.Collections.Generic;
using System.Text;

namespace CrossTask.Core
{
    class PriorityQueue<TKey, TValue>
    {
        private List<KeyValuePair<TKey, TValue>> _heap;
        private IComparer<TKey> _comparer;

        public PriorityQueue() : this(Comparer<TKey>.Default)
        {
        }

        public PriorityQueue(IComparer<TKey> comparer)
        {
            _heap = new List<KeyValuePair<TKey, TValue>>();
            _comparer = comparer;
        }

        // Компаратор в отдельный метод
        private int _comp(int x, int y)
        {
            return _comparer.Compare(_heap[x].Key, _heap[y].Key);
        }

        // Добавить елемент - добавить в конець и сделать просеивание по верху
        public void Enqueue(TKey key, TValue value)
        {
            KeyValuePair<TKey, TValue> tmp = new KeyValuePair<TKey, TValue>(key, value);
            _heap.Add(tmp);
            SiftUp();
        }

        // Просеивание вверх по ключу  
        private void SiftUp()
        {
            int cur = _heap.Count - 1;
            while (cur > 0)
            {
                int parents = (cur - 1) / 2;
                if (_comp(cur, parents) < 0) // Если значение TKey потомка ниже - производится обмен элементов между позициями
                    Swap(cur, parents);
                else break; //Если значение TKey потомка выше - выход из метода

                cur = parents;
            }
        }
        // Свап елементов по позиции
        private void Swap(int cur, int parents)
        {
            KeyValuePair<TKey, TValue> tmp = _heap[parents];
            _heap[parents] = _heap[cur];
            _heap[cur] = tmp;
        }
        // Удалить елемент из кучи вернув значение через out parameter, иначе false
        public bool TryDequeue(out TValue result)
        {
            if (_heap.Count == 0)
            {
                result = default(TValue);
                return false;
            }
            result = _dequeue(0).Value;
            return true ;
        }

        // Удалить елемент из кучи вернув пару
        public KeyValuePair<TKey, TValue> Dequeue()
        {
            var temp = _dequeue(0);
            return temp;
        }

        // Метод для удаления элемента по указанной позиции, возвращает значение пары 
        // принимает из метода Dequeue значение 0 - первый элемент, //принимает из метода Delete значение указанное пользователем
        private KeyValuePair<TKey, TValue> _dequeue(int pos)
        {
            KeyValuePair<TKey, TValue> result = _heap[pos];
            _heap[pos] = _heap[_heap.Count - 1];
            _heap.RemoveAt(_heap.Count - 1);
            SiftDown(pos);
            return result;
        }


        // Просеивание кучи вниз
        private void SiftDown(int cur)
        {
            int child = cur * 2 + 2;

            while (child - 1 < _heap.Count)
            {
                if (child == _heap.Count) // родитель имеет одну левую ветку
                {
                    if (_comp(cur, child - 1) > 0)
                        Swap(cur, child - 1);
                    break;
                }

                if (_comp(child - 1, child) < 0) // если две ветки - выбираем ветку с меньшим значением 
                    --child;

                if (_comp(cur, child) < 0) //выходим, если значение находятся в верном порядке (родитель меньше потомка)
                    break;

                Swap(cur, child);
                cur = child;
                child = cur * 2 + 2;
            }

        }

        //так как к Листу значения прикрепляются в конец, Лист станет отсортированным. 
        //принципы сортировки Бинарной кучи не будут нарушены - необходимости добавления в начало и сортировки SiftDown нет
        public void Print()
        {
            List<KeyValuePair<TKey, TValue>> tmpList = new List<KeyValuePair<TKey, TValue>>();
            int i = 1;
            while (_heap.Count > 0)
            {
                KeyValuePair<TKey, TValue> tmp = Dequeue();
                Console.WriteLine(i++ + ":\t" + tmp);
                tmpList.Add(tmp); 
            }
            _heap = tmpList;
        }
    }
}
