% Copyright

implement solver
    open core, list

class facts
    isFinalState : boolean := true.
    goalState : mapM{integer, integer} := erroneous. %final state - two filled by 6 liters cans
    priorQ : priorityQueue::queue{integer, state} := priorityQueue::empty.
    costs : mapM{state, integer} := mapM_redBlack::new().
    parents : mapM{state, state} := mapM_redBlack::new().
    maxValue : integer := 1000.

%Check if transfusable
clauses
    legalTransfusion(L, s(Elems, _)) :-
        First = nth(nth(0, L), Elems),
        Second = nth(nth(1, L), Elems),
        First:isTransfusable(Second).

%Generate new state
clauses
    move_nd(s(Elems, _), S2, L, Cost) :-
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
        S2 = s(Elems2, m(PrevFrom, PrevTo, Cost)).

clauses
    unWrapList(S, [S | Tail]) :-
        if X = parents:tryGet(S) then
            unWrapList(X, Tail)
        else
            Tail = []
        end if.

%DFS algorythm
clauses
    solve(Init, GoalState, Action) :-
        goalState := GoalState,
        costs:set(Init, 0),
        Result = solve1(Init, [Init]),
        Action(Result),
        !.

    solve1(S, PreviousStates) = Result :-
        List = [ R || helper::range(R, 0, 2) ],
        Cost = costs:tryGet(S),
        Combinations = [ L || helper::varia(2, List, L) ],
        foreach Cm in Combinations do
            if legalTransfusion(Cm, S) then
                move_nd(S, S2, Cm, StateCost),
                if not(isMemberBy(comp, S2, PreviousStates)) then
                    priorQ := priorityQueue::insert(priorQ, StateCost, S2)
                end if,
                if not(_ = costs:tryGet(S2)) then
                    costs:set(S2, maxValue)
                end if,
                NewCost = Cost + StateCost,
                if costs:tryGet(S2) > NewCost then
                    costs:set(S2, NewCost),
                    parents:set(S2, S)
                end if
            end if
        end foreach,
        if isFinal(S) then
            unWrapList(S, Out),
            Result = reverse(Out)
        else
            tuple(_, Min) = priorityQueue::tryGetLeast(priorQ),
            priorQ := priorityQueue::deleteLeast(priorQ),
            Result = solve1(Min, [Min | PreviousStates])
        end if.
%----------------------Help clauses-------------------------------
%String presentation of state

clauses
    toString(S) = Result :-
        if s(_, m(From, To, Cost)) = S then
            Step = string::format("\nFrom % to %\t\t Cost - %\n", From:toString(), To:toString(), Cost)
        else
            Step = "No move\n"
        end if,
        s(Elems, _) = S,
        StringList =
            string::concatWithDelimiter(
                [ L ||
                    Y = getMember_nd(Elems),
                    L = Y:toString()
                ],
                ", "),
        Result = string::concat(Step, StringList).

%Check if lists of vessels are equal
clauses
    same([], []).

    same([H1 | R1], [H2 | R2]) :-
        H1:getSize() = H2:getSize(),
        H1:getCapacity() = H2:getCapacity(),
        same(R1, R2).

%Compare states
clauses
    comp(s(Elems1, _), s(Elems2, _)) = equal :-
        same(Elems1, Elems2),
        !.
    comp(_, _) = greater.

%Check if current state is final
clauses
    isFinal(s(Elems, _)) :-
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

end implement solver
