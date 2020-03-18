implement main
    open core, stdio, list, solver

class facts
    initState : state := s([vessel::new(12, 12), vessel::new(5, 0), vessel::new(7, 0)], no_move).
    final : mapM{integer, integer} := initGoal().

class predicates
    initGoal : () -> mapM{integer, integer}.
clauses
    initGoal() = S :-
        S = mapM_redBlack::new(),
        S:set(6, 2).
%Entry point for program

clauses
    run() :-
        console::init(),
        Print =
            { (A) :-
                write("--------------------------FOUND DECISION-------------------------"),
                foreach W in A do
                    writef("\n%\n", solver::toString(W))
                end foreach
            },
        solver::solve(initState, final, Print),
        !
        or
        write("No solution").

end implement main

goal
    console::runUtf8(main::run).
