% Copyright

implement priorityQueue
    open core

clauses
    tryGetLeast_rep([Least | _]) = Least.

clauses
    deleteLeast_rep([]) = [].
    deleteLeast_rep([_Least | Rest]) = Rest.

clauses
    insert_rep([], Pri, Data) = [tuple(Pri, Data)].

    insert_rep(Q1, Pri, Data) = Q0 :-
        [tuple(P1, D1) | Rest] = Q1,
        if Pri <= P1 then
            Q0 = [tuple(Pri, Data) | Q1]
        else
            Q0 = [tuple(P1, D1) | insert_rep(Rest, Pri, Data)]
        end if.

clauses
    insert(queue(Queue), Priority, Data) = queue(insert_rep(Queue, Priority, Data)).

clauses
    tryGetLeast(queue(Queue)) = tryGetLeast_rep(Queue).

clauses
    deleteLeast(queue(Queue)) = queue(deleteLeast_rep(Queue)).

end implement priorityQueue
