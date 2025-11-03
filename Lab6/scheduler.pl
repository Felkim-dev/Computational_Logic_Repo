:- use_module(library(clpfd)).

% predicate to avoid overleap between two tasks
no_overlap(S1, D1, S2, D2) :-
    % Task 1 ends before task 2
    % Or taks 2 end before task 1
    S1 + D1 #=< S2 #\/ S2 + D2 #=< S1.

% Extract info of the predicate task
% task(name,duration,resource)
extract_info_tasks([],[],[],[]).
extract_info_tasks([task(Name,Duration,Resource)|Rest],[Name|Names],[Duration|Durations],[Resource|Resources]):-
    extract_info_tasks(Rest,Names,Durations,Resources).

%Apply durations constraint to the system of constrainst, that won't be executed until labeling is called
apply_duration([],[],[]).
apply_duration([S|Ss],[E|Es],[D|Ds]):-
    E #= S + D,
    apply_duration(Ss,Es,Ds).

% Apply no ovearleap constaint in all the tasks that are needed
apply_no_overleap_constraints([],[],[],_).
apply_no_overleap_constraints([S|Ss],[D|Ds],[R|Rs],AllData):-
    AllData = all(AllStarts,AllDurs,AllRes),
    apply_single_no_overlap(S,D,R, AllStarts, AllDurs, AllRes),
    apply_no_overleap_constraints(Ss,Ds,Rs,AllData).


apply_single_no_overlap(_,_,_,[],[],[]).
apply_single_no_overlap(S1,D1,R1,[S2|Ss],[D2|Ds],[R2|Rs]):-
    ( R1 =:= R2, S1 \== S2 
    -> no_overlap(S1,D1,S2,D2)
    ;true
    ),
    apply_single_no_overlap(S1,D1,R1,Ss,Ds,Rs).

% Apply precedeces to the tasks
apply_precedences([], _,_,_).
apply_precedences([prec(Before, After)|Precs], Names, Starts, Ends):-
    %Obtains the index of the Before parameter of prec into the list names and saves thi in IdxB
    nth0(IdxB, Names, Before),
    nth0(IdxA, Names, After),
    nth0(IdxB, Ends, EndsBefore),
    nth0(IdxA, Starts, StartsAfter),
    EndsBefore #=< StartsAfter,
    apply_precedences(Precs,Names,Starts,Ends).


schedule(Tasks,Precedences,Schedule, Makespan):-

    extract_info_tasks(Tasks,Names,Durations,Resources),

    %Count the number of taks and saves it in N
    length(Tasks, N),
    %Create a list with the lenght of N that names Starts and Ends
    length(Starts, N),
    length(Ends, N),
    
    % Define domain for start times, end times, and makespan (0 to 100)
    Starts ins 0..100,
    Ends ins 0..100,
    Makespan in 0..100,
    
    apply_duration(Starts,Ends,Durations),
    
    apply_no_overleap_constraints(Starts,Durations,Resources,all(Starts,Durations,Resources)),

    apply_precedences(Precedences,Names,Starts,Ends),
    
    % Makespan must be greater than or equal to all end times
    maplist(#>=(Makespan), Ends),

    % Combine all variables to be labeled (Starts + Makespan)
    append(Starts,[Makespan],Vars),
    
    % Find solution that minimizes Makespan using first-fail heuristic
    labeling([ff,min(Makespan)], Vars),

    % Build the final schedule structure with all task information
    build_schedule(Names, Durations, Resources, Starts, Ends, Schedule).


% Base case: all lists are empty, schedule is complete
build_schedule([], [], [], [], [], []).
% Recursive case: build schedule by combining task info into task_schedule structures
build_schedule([N|Ns], [D|Ds], [R|Rs], [S|Ss], [E|Es], 
               [task_schedule(N,D,R,S,E)|Rest]) :-
    build_schedule(Ns, Ds, Rs, Ss, Es, Rest).

print_schedule(Schedule, Makespan) :-
    nl,
    format('Makespan: ~w~n', [Makespan]),
    writeln('Task - Duration - Resource - Start - End'),
    print_tasks(Schedule),
    nl.

print_tasks([]).
print_tasks([task_schedule(Name, Dur, Res, Start, End)|Rest]) :-
    format('~w - ~w - ~w - ~w - ~w~n', [Name, Dur, Res, Start, End]),
    print_tasks(Rest).

test5 :-
    Tasks = [task(design, 3, team_a),
             task(frontend, 5, team_a),
             task(backend, 6, team_b),
             task(database, 4, team_b),
             task(testing, 3, team_c),
             task(deployment, 2, team_c)],
    Precs = [prec(design, frontend),
             prec(design, backend),
             prec(backend, database),
             prec(frontend, testing),
             prec(database, testing),
             prec(testing, deployment)],
    schedule(Tasks, Precs, Schedule, Makespan),
    print_schedule(Schedule, Makespan).

% TEST 1: Basic case - no precedences, resource conflicts
% Expected: Tasks with same resource cannot overlap
test1 :-
    Tasks = [task(a, 3, 1), task(b, 2, 1), task(c, 2, 2)],
    Precs = [],
    schedule(Tasks, Precs, Schedule, Makespan),
    print_schedule(Schedule, Makespan).

% TEST 2: Medium complexity - precedences and resource conflicts
% Expected: Respect both precedence and resource constraints
test2 :-
    Tasks = [task(a, 4, 1), task(b, 3, 2), task(c, 2, 1), task(d, 3, 2)],
    Precs = [prec(a, c), prec(b, d)],
    schedule(Tasks, Precs, Schedule, Makespan),
    print_schedule(Schedule, Makespan).

% TEST 3: Complex case - multiple precedences and shared resources
% Expected: Optimal schedule respecting all constraints
test3 :-
    Tasks = [task(t1, 5, 1),
             task(t2, 7, 1),
             task(t3, 4, 2),
             task(t4, 6, 3),
             task(t5, 5, 3),
             task(t6, 8, 1)],
    Precs = [prec(t1, t2),
             prec(t2, t3),
             prec(t2, t4),
             prec(t3, t6),
             prec(t4, t6)],
    schedule(Tasks, Precs, Schedule, Makespan),
    print_schedule(Schedule, Makespan).