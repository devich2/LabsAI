implement main
    open core, stdio

domains
    state = s(vessel* Elems). %state - list of vessels/cans
    final = f(integer* Sizes, integer* Count). %e.g. f([10,20],[3,4]) - final state then will be three 10-l filled and four 20-l filled cans
    move = m(vessel From, vessel To, state NewState, integer Cost). %move info

class facts
    isFinalState : boolean := true.
    goalState : final := f([6], [2]). %final state - two filled by 6 liters cans
    initState : state := s([vessel::new(12, 12), vessel::new(5, 0), vessel::new(7, 0)]). %initial state according to the task

class predicates
    solve : (state InitState) -> move* MoveList determ.
    solve1 : (state S1, state* PreviousStates) -> move* MoveList nondeterm.
    move_nd : (state Before, state After [out], integer* Group) -> move Move.
    legalTransfusion : (integer* L, state State) nondeterm.
    isFinal : (state State, final Final) determ.
    toString : (state State) -> string Presentation.
    same : (vessel*, vessel*) determ.
    comp : comparator{state, state}.

%Check if transfusable
clauses
    legalTransfusion(L, s(Elems)) :-
        First = list::nth(list::nth(0, L), Elems),
        Second = list::nth(list::nth(1, L), Elems),
        First:isTransfusable(Second).

%Generate new state
clauses
    move_nd(s(Elems), S2, L) = m(PrevFrom, PrevTo, S2, Cost) :-
        Elems2 =
            [ R ||
                Y = list::getMember_nd(Elems),
                R = Y:deepCopy()
            ],
        From = list::nth(list::nth(0, L), Elems2),
        To = list::nth(list::nth(1, L), Elems2),
        PrevFrom = From:deepCopy(),
        PrevTo = To:deepCopy(),
        Cost = From:transfuse(To),
        S2 = s(Elems2).

%DFS algorythm
clauses
    solve(Init) = MoveList :-
        MoveList = solve1(Init, [Init]),
        !.

    solve1(S, PreviousStates) = [Move | MoveList] :-
        List = [ R || helper::range(R, 0, 2) ],
        helper::varia(2, List, L),
        legalTransfusion(L, S),
        Move = move_nd(S, S2, L),
        not(list::isMemberBy(comp, S2, PreviousStates)),
        if isFinal(S2, goalState) then
            MoveList = [],
            !
        else
            MoveList = solve1(S2, [S2 | PreviousStates])
        end if.

%Entry point for program
clauses
    run() :-
        console::init(),
        if MoveList = solve(initState) then
            stdio::write("--------------------FOUND DECISION----------------------------"),
            foreach m(A, B, Prev, Cost) = list::getMember_nd(MoveList) do
                stdio::writef("\nFrom % to %\t\t Cost - %\n%\n", A:toString(), B:toString(), Cost, toString(Prev))
            end foreach
        else
            stdio::write("No solution")
        end if.

%----------------------Help clauses-------------------------------
%String presentation of state
clauses
    toString(s(Elems)) =
        string::concatWithDelimiter(
            [ L ||
                Y = list::getMember_nd(Elems),
                L = Y:toString()
            ],
            ", ").

%Check if lists of vessels are equal
clauses
    same([], []).

    same([H1 | R1], [H2 | R2]) :-
        H1:getSize() = H2:getSize(),
        H1:getCapacity() = H2:getCapacity(),
        same(R1, R2).

%Compare states
clauses
    comp(s(Elems1), s(Elems2)) = equal :-
        same(Elems1, Elems2),
        !.
    comp(_, _) = greater.

%Check if current state is final
clauses
    isFinal(s(Elems), f(Sizes, Count)) :-
        isFinalState := true,
        foreach
            X in Sizes
            and if false = isFinalState then
                !,
                fail
            end if
        do
            IndexList =
                [ I ||
                    list::memberIndex_nd(AA, I, Elems),
                    AA:getSize() = X
                ],
            if list::length(IndexList) < list::nth(list::tryGetIndex(X, Sizes), Count) then
                isFinalState := false
            end if
        end foreach,
        isFinalState = true.

end implement main

goal
    console::runUtf8(main::run).
