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

    append([], X, X).
    append([X | Y], Z, [X | W]) :-
        append(Y, Z, W).

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
                    AA = X
                ],
            if list::length(IndexList) < list::nth(list::tryGetIndex(X, vessels), count) then
                continue := false
            end if
        end foreach,
        stdio::write(continue),
        if continue = false then
            fail
        end if.

    generateStates(State) = Result :-
        Combs = [ L || helper::varia(2, State:getElems(), L) ],
        Result =
            [ L ||
                Group in Combs,
                list::nth(0, Group):isTransfusable(list::nth(1, Group)),
                L = changeState(State:deepCopy(), Group)
            ].

clauses
    unWrapList(Final) :-
        exception::raise_notImplemented().

clauses
    rec_solve(Initial) :-
        if isFinal(Initial) then
            stdio::write("NICE"),
            console::init(), % инициализация консоли
            _ = console::readChar() % пауза, ожидания ввода строки с Enter
        else
            foreach Gen in generateStates(Initial) do
                if list::isMember(Gen, history) then
                else
                    stdio::write("HEILO\n"),
                    history := list::append(history, [Gen]),
                    stack := list::append([Gen], stack),
                    stdio::writef("STECK%\n", list::length(stack))
                end if
            end foreach,
            First = list::nth(0, stack),
            stack := list::remove(stack, First),
            rec_solve(First)
        end if.

clauses
    solve(Initial) :-
        stack := [Initial],
        history := [Initial],
        rec_solve(Initial).

clauses
    changeState(Initial, Group) = Result :-
        if Index1 = list::tryGetIndex(list::nth(0, Group), Initial:getElems()) and Index2 = list::tryGetIndex(list::nth(1, Group), Initial:getElems())
        then
            From = list::nth(Index1, Initial:getElems()),
            To = list::nth(Index2, Initial:getElems()),
            Initial:setCost(From:transfuse(To)),
            Initial:setFrom(list::nth(0, Group)),
            Initial:setTo(list::nth(1, Group)),
            stdio::write("Nice")
        end if,
        Result = Initial.

end implement solver
