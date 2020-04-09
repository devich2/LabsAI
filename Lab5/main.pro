implement main
    open core, stdio, list, solver

class facts
    initState : state := s([vessel::new(12, 12), vessel::new(5, 0), vessel::new(7, 0)], no_move).
    final : mapM{integer, integer} := initGoal().
    trLtr : integer := 0.

class predicates
    initGoal : () -> mapM{integer, integer}.
    test : ().

clauses
    initGoal() = S :-
        S = mapM_redBlack::new(),
        S:set(6, 2).
    test() :-
        TestData =
            [
                s([vessel::new(12, 12), vessel::new(5, 0), vessel::new(7, 0)], no_move),
                s([vessel::new(12, 8), vessel::new(5, 2), vessel::new(7, 2), vessel::new(10, 3)], no_move),
                s([vessel::new(12, 12), vessel::new(5, 0), vessel::new(7, 4), vessel::new(10, 2)], no_move)
            ],
        ShortPrint =
            { (A) :-
                foreach W in A do
                    if s(_, m(_, _, Cost)) = W then
                        trLtr := trLtr + Cost
                    end if
                end foreach,
                writef("TotalSteps: %\n", length(A)),
                writef("Transfused liters: %\n", trLtr)
            },
        foreach Data in TestData do
            write("--------------------------Solve result-------------------------\n"),
            write("--------With Heuristic-------------\n"),
            if solver::solve(Data, final, ShortPrint, true) then
            end if,
            !,
            write("\n--------Without Heuristic-------------\n"),
            if solver::solve(Data, final, ShortPrint, false) then
            end if,
            !
        end foreach.
%Entry point for program

clauses
    run() :-
        console::init(),
        Print =
            { (A) :-
                write("--------------------------FOUND DECISION-------------------------"),
                foreach W in A do
                    writef("\n%\n", solver::toString(W)),
                    if s(_, m(_, _, Cost)) = W then
                        trLtr := trLtr + Cost
                    end if
                end foreach,
                writef("TotalSteps: %\n", length(A)),
                writef("Transfused liters: %", trLtr)
            },
        solver::solve(initState, final, Print, true),
        test(),
        !
        or
        write("No solution").

end implement main

goal
    console::runUtf8(main::run).
