% Copyright

implement solver
    open core, list

class facts
    isFinalState : boolean := true.
    goalState : mapM{integer, integer} := erroneous.

%Check if transfusable
clauses
    legalTransfusion(L, s(Elems)) :-
        First = nth(nth(0, L), Elems),
        Second = nth(nth(1, L), Elems),
        First:isTransfusable(Second).

%Generate new state
clauses
    move_nd(s(Elems), S2, L) = m(PrevFrom, PrevTo, S2, Cost) :-
        Elems2 =
            [ R ||
                Y = getMember_nd(Elems),
                R = Y:clone()
            ],
        From = nth(nth(0, L), Elems2),
        To = nth(nth(1, L), Elems2),
        PrevFrom = From:clone(),
        PrevTo = To:clone(),
        Cost = From:transfuse(To),
        S2 = s(Elems2).

%DFS algorythm
clauses
    solve(Init, GoalState) = MoveList :-
        goalState := GoalState,
        MoveList = solve1(Init, [Init]),
        !.

    solve1(S, PreviousStates) = [Move | MoveList] :-
        List = [ R || helper::range(R, 0, 2) ],
        helper::varia(2, List, L),
        legalTransfusion(L, S),
        Move = move_nd(S, S2, L),
        not(isMemberBy(comp, S2, PreviousStates)),
        if isFinal(S2) then
            MoveList = [],
            !
        else
            MoveList = solve1(S2, [S2 | PreviousStates])
        end if.
        %----------------------Help clauses-------------------------------
%String presentation of state

clauses
    toString(s(Elems)) =
        string::concatWithDelimiter(
            [ L ||
                Y = getMember_nd(Elems),
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
    isFinal(s(Elems)) :-
        isFinalState := true,
        foreach
            tuple(Size, Count) = goalState:getAll_nd()
            and if false = isFinalState then
                !,
                fail
            end if
        do
            IndexList =
                [ I ||
                    memberIndex_nd(AA, I, Elems),
                    AA:getSize() = Size
                ],
            if length(IndexList) < Count then
                isFinalState := false
            end if
        end foreach,
        isFinalState = true.

end implement
