% Copyright

implement main
    open core, stdio

clauses
    run() :-
        Ves1 = vessel::new(12, 12),
        Ves2 = vessel::new(5, 0),
        Ves3 = vessel::new(7, 0),
        Ves4 = vessel::new(20, 6),
        State1 = state::new([Ves1, Ves2, Ves3]),
        Solver = solver::new([Ves4], [2]),
        (Solver:solve(State1) and write("EndingWork") or write("NoDecision")),
        !.

/*(push(2, [1], L) and pop(X, L, B) and write(B) and ! or write("Bad"))*/
end implement main

goal
    console::runUtf8(main::run).
