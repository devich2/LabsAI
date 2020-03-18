implement main
    open core, list, stdio, solver

class predicates
    initGoal : () -> mapM{integer, integer}.
    initOriginal : () -> state.

class facts
    initState : state := initOriginal(). %initial state according to the task
    goalState : mapM{integer, integer} := initGoal().

%Init goal state
clauses
    initGoal() = S :-
        S = mapM_redBlack::new(),
        S:set(6, 2).
    initOriginal() = s([vessel::new(12, 12), vessel::new(5, 0), vessel::new(7, 0)]).

%Entry point for program
clauses
    run() :-
        console::init(),
        if MoveList = solver::solve(initState, goalState) then
            write("--------------------FOUND DECISION----------------------------"),
            foreach m(A, B, New, Cost) = getMember_nd(MoveList) do
                writef("\nFrom % to %\t\t Cost - %\n%\n", A:toString(), B:toString(), Cost, solver::toString(New))
            end foreach
        else
            write("No solution")
        end if.

end implement main

goal
    console::runUtf8(main::run).
