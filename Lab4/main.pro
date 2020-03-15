% Copyright

implement main
    open core, stdio

clauses
    run() :-
        Ves1 = vessel::new(10, 4),
        Ves2 = vessel::new(30, 11),
        Ves3 = vessel::new(10, 0),
        Ves4 = vessel::new(30, 15),
        State1 = state::new([Ves1, Ves2]),
        Solver = solver::new([Ves3, Ves4], [1, 1]),
        (Solver:solve(State1) and write("Yes") or write("Not")),
        !.
        /*(push(2, [1], L) and pop(X, L, B) and write(B) and ! or write("Bad"))*/

end implement main

goal
    console::runUtf8(main::run).
