% Copyright

implement solver
    open core

facts
    vessels : vessel*.
    count : integer*.
    continue : boolean := erroneous.
    stack : state* := [].
    history : state* := [].

clauses
    new(Vessels, Count) :-
        vessels := Vessels,
        count := Count.

clauses
    equals(A, B) = equal :-
        A = B,
        !.
    equals(_, _) = greater.

clauses
    isFinal(State) :-
        continue := true,
        Vessels = State:getElems(),
        foreach
            X in vessels
            and if false = continue then
                !,
                fail
            end if
        do
            IndexList =
                [ I ||
                    list::memberIndex_nd(AA, I, Vessels),
                    AA:getSize() = X:getSize()
                ],
            if list::length(IndexList) < list::nth(list::tryGetIndex(X, vessels), count) then
                continue := false
            end if
        end foreach,
        if continue = false then
            fail
        end if.

    generateStates(State) = Result :-
        Elems = State:getElems(),
        List = [ R || helper::range(R, 0, list::length(Elems) - 1) ],
        Combs = [ L || helper::varia(2, List, L) ],
        Result =
            [ L ||
                Group in Combs,
                list::nth(list::nth(0, Group), Elems):isTransfusable(list::nth(list::nth(1, Group), Elems)),
                L = changeState(State:deepCopy(), Group)
            ].

clauses
    unWrapList(Final, Tail) = Result :-
        if not(Final:empty_parent()) then
            Parent = Final:getParent(),
            Result = unWrapList(Parent, [Parent | Tail])
        else
            Result = Tail
        end if.

clauses
    rec_solve(Initial) :-
        /*stdio::writef("New iter -----\n%", Initial:toString()),*/
        if isFinal(Initial) then
            stdio::write("---------------------FOUND DECISION-----------------------------------------"),
            List = unWrapList(Initial, [Initial]),
            foreach X in List do
                stdio::write(X:toString())
            end foreach,
            console::init(),
            _ = console::readChar()
        else
            foreach Gen in generateStates(Initial) do
                if list::isMemberBy(comp, Gen, history) then
                else
                    /*stdio::writef("\nGeneratedState\n%\n", Gen:toString()),*/
                    Gen:setParent(Initial),
                    history := list::append(history, [Gen]),
                    stack := list::append([Gen], stack)
                end if
            end foreach,
            /* stdio::writef("History %", list::length(history)),*/
            First = list::nth(0, stack),
            stack := list::remove(stack, First),
            rec_solve(First)
        end if.

clauses
    cp(A, B) = equal :-
        A:getSize() = B:getSize(),
        A:getCapacity() = B:getCapacity(),
        !.
    cp(_, _) = greater.

    comp(A, B) = equal :-
        Elems1 = A:getElems(),
        Elems2 = B:getElems(),
        same(Elems1, Elems2),
        !.
    comp(_, _) = greater.

clauses
    solve(Initial) :-
        stack := [Initial],
        history := [Initial],
        rec_solve(Initial).

clauses
    same([], []).

    same([H1 | R1], [H2 | R2]) :-
        H1:getSize() = H2:getSize(),
        H1:getCapacity() = H2:getCapacity(),
        same(R1, R2).

clauses
    changeState(Initial, Group) = Result :-
        Index1 = list::nth(0, Group),
        Index2 = list::nth(1, Group),
        From = list::nth(Index1, Initial:getElems()),
        To = list::nth(Index2, Initial:getElems()),
        From1 = From:deepCopy(),
        To1 = To:deepCopy(),
        Initial:setFrom(From1),
        Initial:setTo(To1),
        Initial:setCost(From:transfuse(To)),
        Result = Initial.

end implement solver
