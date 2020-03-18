% Copyright

class priorityQueue
    open core

domains
    queue_rep{Priority, Data} = tuple{Priority, Data}*.

domains
    queue{Priority, Data} = queue(queue_rep{Priority, Data}).

constants
    empty : queue{Priority, Data} = queue([]).

predicates
    tryGetLeast_rep : (queue_rep{Priority, Data} Queue) -> tuple{Priority, Data} Least determ.

predicates
    deleteLeast_rep : (queue_rep{Priority, Data} Queue1) -> queue_rep{Priority, Data} Queue.

predicates
    insert_rep : (queue_rep{Pri, Data} Q1, Pri P, Data D) -> queue_rep{Pri, Data} Q0.

predicates
    insert : (queue{Pri, Data} Q1, Pri Pri, Data Data) -> queue{Pri, Data} Q0.

predicates
    tryGetLeast : (queue{Priority, Data} Queue) -> tuple{Priority, Data} Least determ.

predicates
    deleteLeast : (queue{Priority, Data} Queue1) -> queue{Priority, Data} Queue.

end class priorityQueue
