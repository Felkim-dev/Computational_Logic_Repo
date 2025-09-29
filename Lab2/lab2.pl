% ===============================================
% EXPERT SYSTEM COMPUTERS AND LAPTOPS TROUBLESHOOTING
% ===============================================

% ===============================================
% KNOWLEDGE BASE - FACTS
% ===============================================

% POWER ISSUES
power_issue(computer_wont_boot).
power_issue(laptop_battery_dead).
power_issue(power_supply_failure).
power_issue(motherboard_dead).

% DISPLAY ISSUES
display_issue(blue_screen_death).
display_issue(black_screen).
display_issue(display_flickering).
display_issue(laptop_screen_broken).

% HARDWARE ISSUES
hardware_issue(hard_drive_clicking).
hardware_issue(ram_memory_error).
hardware_issue(overheating_cpu).
hardware_issue(keyboard_not_working).
hardware_issue(touchpad_not_working).
hardware_issue(usb_ports_dead).

% PERFORMANCE ISSUES
performance_issue(computer_very_slow).
performance_issue(startup_very_slow).
performance_issue(frequent_freezing).
performance_issue(programs_crash).

% AFFECTS
affects_laptop(laptop_battery_dead).
affects_laptop(laptop_screen_broken).
affects_laptop(touchpad_not_working).
affects_laptop(overheating).
affects_laptop(keyboard_not_working).

affects_desktop(power_supply_failure).
affects_desktop(motherboard_dead).
affects_desktop(computer_wont_start).
affects_desktop(blue_screen).
affects_desktop(hard_drive_failure).

affects_both(blue_screen_death).
affects_both(computer_very_slow).
affects_both(hard_drive_clicking).
affects_both(ram_memory_error).
affects_both(overheating_cpu).

% SPECIFIC SYMPTOMS
shows_error_message(blue_screen).
shows_error_message(application_crash).
shows_error_message(driver_issues).
shows_error_message(operating_system_corrupt).

makes_noise(hard_drive_failure).
makes_noise(overheating).
makes_noise(fan_problems).

runs_slowly(slow_performance).
runs_slowly(virus_infection).
runs_slowly(hard_drive_failure).
runs_slowly(low_memory).

gets_hot(overheating).
gets_hot(laptop_battery_issues).
gets_hot(graphics_problems).

affects_mobile(phone_battery_drain).
affects_mobile(app_crashes_mobile).
affects_mobile(storage_full).

% ===============================================
% CLASSIFICATION RULES
% ===============================================

% CLASSIFICATION BY PROBLEM TYPE
is_power_problem(X) :- power_issue(X).
is_display_problem(X) :- display_issue(X).
is_performance_problem(X) :- performance_issue(X).
is_hardware_problem(X) :- hardware_issue(X).

% CLASSIFICATION BY DEVICE
laptop_specific(X) :- affects_laptop(X).
desktop_specific(X) :- affects_desktop(X).
universal_problem(X) :- affects_both(X).

% URGENCY LEVEL
critical_problem(X) :- power_issue(X).
critical_problem(hard_drive_clicking).
moderate_problem(X) :- display_issue(X).
moderate_problem(X) :- performance_issue(X).
minor_problem(keyboard_not_working).
minor_problem(touchpad_not_working).
minor_problem(usb_ports_dead).

% ===============================================
% QUESTION SYSTEM
% ===============================================

ask(Question, Answer) :-
    write('Does your computer '), write(Question), write('? (yes/no): '),
    read(Answer).

% ===============================================
% MAIN INFERENCE ENGINE
% ===============================================

diagnose_computer :-
    write('==============================================='), nl,
    write('COMPUTER AND LAPTOP DIAGNOSIS'), nl,
    write('==============================================='), nl,
    write('I will help you diagnose specific problems'), nl,
    write('with desktop computers and laptops.'), nl,
    write('Answer with "yes" or "no".'), nl, nl,
    
    identify_computer_problem(Problem),
    
    nl, write('DIAGNOSIS: '), write(Problem), nl,
    provide_solution(Problem),
    show_problem_info(Problem).

identify_computer_problem(Problem) :-
    ask('turn on (lights, fans, sounds)', PowersOn),
    (PowersOn == no ->
        diagnose_power_failure(Problem)
    ;   ask('show image on screen', HasDisplay),
        (HasDisplay == no ->
            diagnose_display_failure(Problem)
        ;   ask('show error messages or blue screen', ShowsErrors),
            (ShowsErrors == yes ->
                diagnose_system_errors(Problem)
            ;   ask('work but very slowly', PerformanceIssue),
                (PerformanceIssue == yes ->
                    diagnose_performance_issues(Problem)
                ;   ask('make strange noises or get too hot', PhysicalSymptoms),
                    (PhysicalSymptoms == yes ->
                        diagnose_hardware_symptoms(Problem)
                    ;   ask('have any specific component not working (keyboard, mouse, USB)', ComponentIssue),
                        (ComponentIssue == yes ->
                            diagnose_component_failure(Problem)
                        ;   Problem = 'unidentified problem - requires technical diagnosis'
                        )
                    )
                )
            )
        )
    ).

% Diagnosis for power/boot problems
diagnose_power_failure(Problem) :-
    ask('Is it a laptop', IsLaptop),
    (IsLaptop == yes ->
        ask('Is the charger LED on', ChargerLED),
        (ChargerLED == yes ->
            ask('Have you tried turning on without battery (charger only)', TriedWithoutBattery),
            (TriedWithoutBattery == yes ->
                Problem = motherboard_dead
            ;   Problem = laptop_battery_dead
            )
        ;   Problem = laptop_battery_dead
        )
    ;   ask('Do you hear fans or see lights when pressing power', AnyActivity),
        (AnyActivity == yes ->
            ask('Do fans stop after a few seconds', FansStop),
            (FansStop == yes ->
                Problem = motherboard_dead
            ;   Problem = power_supply_failure
            )
        ;   Problem = power_supply_failure
        )
    ).

% Diagnosis for display problems
diagnose_display_failure(Problem) :-
    ask('Is it a laptop', IsLaptop),
    (IsLaptop == yes ->
        ask('Can you see the screen if you tilt it or press it', ScreenResponds),
        (ScreenResponds == yes ->
            Problem = laptop_screen_broken
        ;   ask('Did you connect an external monitor and it works', ExternalWorks),
            (ExternalWorks == yes ->
                Problem = laptop_screen_broken
            ;   Problem = black_screen
            )
        )
    ;   ask('Did you try another video cable (HDMI, VGA)', TriedOtherCable),
        (TriedOtherCable == yes ->
            ask('Did you try another monitor', TriedOtherMonitor),
            (TriedOtherMonitor == yes ->
                Problem = black_screen
            ;   Problem = display_flickering
            )
        ;   Problem = black_screen
        )
    ).

% Diagnosis for system errors
diagnose_system_errors(Problem) :-
    ask('Does the screen turn completely blue with white text', IsBSOD),
    (IsBSOD == yes ->
        Problem = blue_screen_death
    ;   ask('Do only certain applications fail or close', SpecificApps),
        (SpecificApps == yes ->
            Problem = programs_crash
        ;   Problem = blue_screen_death
        )
    ).

% Diagnosis for performance problems
diagnose_performance_issues(Problem) :-
    ask('Is the problem mainly when starting Windows', SlowStartup),
    (SlowStartup == yes ->
        Problem = startup_very_slow
    ;   ask('Does the computer freeze completely and you must restart it', FreezesCompletely),
        (FreezesCompletely == yes ->
            Problem = frequent_freezing
        ;   Problem = computer_very_slow
        )
    ).

% Diagnosis for physical hardware symptoms
diagnose_hardware_symptoms(Problem) :-
    ask('Are there clicking sounds coming from the hard drive', ClickingSounds),
    (ClickingSounds == yes ->
        Problem = hard_drive_clicking
    ;   ask('Does the computer get very hot and fans run very fast', OverheatsQuickly),
        (OverheatsQuickly == yes ->
            Problem = overheating_cpu
        ;   Problem = overheating_cpu  % Default if there are physical symptoms
        )
    ).

% Diagnosis for specific component failures
diagnose_component_failure(Problem) :-
    ask('Is it a laptop', IsLaptop),
    (IsLaptop == yes ->
        ask('Does the touchpad not respond', TouchpadIssue),
        (TouchpadIssue == yes ->
            Problem = touchpad_not_working
        ;   ask('Does the keyboard not work or several keys fail', KeyboardIssue),
            (KeyboardIssue == yes ->
                Problem = keyboard_not_working
            ;   Problem = usb_ports_dead
            )
        )
    ;   ask('Do USB ports not recognize any device', USBIssue),
        (USBIssue == yes ->
            Problem = usb_ports_dead
        ;   ask('Does the keyboard not respond', KeyboardIssue),
            (KeyboardIssue == yes ->
                Problem = keyboard_not_working
            ;   Problem = ram_memory_error
            )
        )
    ).

% ===============================================
% SPECIFIC SOLUTIONS
% ===============================================

provide_solution(computer_wont_boot) :-
    write('SOLUTION:'), nl,
    write('1. Check that power cable is properly connected'), nl,
    write('2. Try with another power outlet'), nl,
    write('3. If laptop, try without battery, charger only'), nl.

provide_solution(laptop_battery_dead) :-
    write('SOLUTION:'), nl,
    write('1. Connect charger and wait 30 minutes'), nl,
    write('2. Try turning on with charger only (no battery)'), nl,
    write('3. If it does not work, battery needs replacement'), nl.

provide_solution(power_supply_failure) :-
    write('SOLUTION:'), nl,
    write('1. Check all internal power connections'), nl,
    write('2. Try with another compatible power supply'), nl,
    write('3. Requires power supply replacement'), nl.

provide_solution(motherboard_dead) :-
    write('SOLUTION:'), nl,
    write('CRITICAL PROBLEM - Damaged motherboard'), nl,
    write('1. Requires professional diagnosis'), nl,
    write('2. Possible motherboard replacement'), nl,
    write('3. Consider if repair is worth it vs buying new'), nl.

provide_solution(blue_screen_death) :-
    write('SOLUTION:'), nl,
    write('1. Restart in Safe Mode (F8 at startup)'), nl,
    write('2. Run "sfc /scannow" in command prompt'), nl,
    write('3. Update or uninstall recent drivers'), nl,
    write('4. Run RAM memory diagnostic'), nl.

provide_solution(black_screen) :-
    write('SOLUTION:'), nl,
    write('1. Check video cable connection'), nl,
    write('2. Try with another monitor/cable'), nl,
    write('3. Reset BIOS (remove CMOS battery 5 minutes)'), nl,
    write('4. Remove and reinstall graphics card'), nl.

provide_solution(laptop_screen_broken) :-
    write('SOLUTION:'), nl,
    write('1. Connect external monitor to confirm'), nl,
    write('2. Check screen flex cable (technical service)'), nl,
    write('3. LCD screen replacement'), nl.

provide_solution(computer_very_slow) :-
    write('SOLUTION:'), nl,
    write('1. Run full antivirus scan'), nl,
    write('2. Clean temporary files (disk cleanup)'), nl,
    write('3. Uninstall unnecessary programs'), nl,
    write('4. Consider adding more RAM or changing to SSD'), nl.

provide_solution(startup_very_slow) :-
    write('SOLUTION:'), nl,
    write('1. Disable unnecessary startup programs'), nl,
    write('2. Run disk cleanup and defragmentation'), nl,
    write('3. Check for malware'), nl,
    write('4. Consider SSD upgrade'), nl.

provide_solution(frequent_freezing) :-
    write('SOLUTION:'), nl,
    write('1. Check RAM with memory diagnostic tool'), nl,
    write('2. Update all drivers'), nl,
    write('3. Check hard drive health'), nl,
    write('4. Monitor CPU temperature'), nl.

provide_solution(programs_crash) :-
    write('SOLUTION:'), nl,
    write('1. Update the problematic software'), nl,
    write('2. Reinstall the crashing programs'), nl,
    write('3. Check Windows updates'), nl,
    write('4. Run system file checker'), nl.

provide_solution(hard_drive_clicking) :-
    write('SOLUTION:'), nl,
    write('URGENT - HARD DRIVE FAILING'), nl,
    write('1. BACKUP DATA IMMEDIATELY'), nl,
    write('2. Do not use computer until backup is done'), nl,
    write('3. Replace hard drive'), nl,
    write('4. Restore data from backup'), nl.

provide_solution(overheating_cpu) :-
    write('SOLUTION:'), nl,
    write('1. Turn off computer and let it cool down'), nl,
    write('2. Clean fans and vents with compressed air'), nl,
    write('3. Reapply thermal paste on CPU'), nl,
    write('4. Check that all fans are working'), nl.

provide_solution(keyboard_not_working) :-
    write('SOLUTION:'), nl,
    write('1. If USB, try another port'), nl,
    write('2. Restart keyboard drivers in Device Manager'), nl,
    write('3. If laptop, check for stuck keys'), nl,
    write('4. Replacement if physically damaged'), nl.

provide_solution(touchpad_not_working) :-
    write('SOLUTION:'), nl,
    write('1. Check if it is not disabled (Fn + touchpad key)'), nl,
    write('2. Update touchpad drivers'), nl,
    write('3. Clean touchpad surface'), nl.

provide_solution(usb_ports_dead) :-
    write('SOLUTION:'), nl,
    write('1. Try different USB devices'), nl,
    write('2. Update USB controllers in Device Manager'), nl,
    write('3. Check power management settings'), nl,
    write('4. May require motherboard repair'), nl.

provide_solution(ram_memory_error) :-
    write('SOLUTION:'), nl,
    write('1. Run Windows Memory Diagnostic'), nl,
    write('2. Test RAM modules individually'), nl,
    write('3. Clean RAM contacts'), nl,
    write('4. Replace faulty RAM modules'), nl.

provide_solution(_) :-
    write('SOLUTION:'), nl,
    write('Problem requires specialized technical diagnosis'), nl.

% ===============================================
% ADDITIONAL PROBLEM INFORMATION
% ===============================================

show_problem_info(Problem) :-
    nl, write('ADDITIONAL INFORMATION:'), nl,
    (critical_problem(Problem) ->
        write('CRITICAL PROBLEM - Immediate attention required'), nl
    ; moderate_problem(Problem) ->
        write('MODERATE PROBLEM - Should be solved soon'), nl
    ; minor_problem(Problem) ->
        write('MINOR PROBLEM - Not urgent'), nl
    ; true
    ),
    
    (laptop_specific(Problem) ->
        write('LAPTOP specific problem'), nl
    ; desktop_specific(Problem) ->
        write('DESKTOP COMPUTER specific problem'), nl
    ; universal_problem(Problem) ->
        write('Applies to BOTH computer types'), nl
    ; true
    ).

% ===============================================
% UTILITIES AND TESTS
% ===============================================

% List all known problems
list_computer_problems :-
    write('COMPUTER AND LAPTOP PROBLEMS:'), nl, nl,
    write('Power Problems:'), nl,
    forall(power_issue(P), (write('  - '), write(P), nl)),
    nl,
    write('Display Problems:'), nl,
    forall(display_issue(P), (write('  - '), write(P), nl)),
    nl,
    write('Performance Problems:'), nl,
    forall(performance_issue(P), (write('  - '), write(P), nl)),
    nl,
    write('Hardware Problems:'), nl,
    forall(hardware_issue(P), (write('  - '), write(P), nl)),
    nl.

% Specific information about a problem
computer_problem_details(Problem) :-
    write('DETAILS: '), write(Problem), nl,
    write('======================================='), nl,
    provide_solution(Problem),
    show_problem_info(Problem).

% ===============================================
% MAIN MENU
% ===============================================

start_computer_expert :-
    write('==============================================='), nl,
    write('EXPERT SYSTEM: COMPUTERS AND LAPTOPS'), nl,
    write('==============================================='), nl,
    write('Specialized in diagnosing:'), nl,
    write('• Desktop computers'), nl,
    write('• Laptops and notebooks'), nl,
    write('• Hardware and software problems'), nl, nl,
    write('AVAILABLE COMMANDS:'), nl,
    write('1. diagnose_computer.              - Start diagnosis'), nl,
    write('2. list_computer_problems.         - View all problems'), nl,
    write('3. computer_problem_details(X).    - Details of problem X'), nl, nl,
    write('USAGE EXAMPLE:'), nl,
    write('?- diagnose_computer.'), nl, nl.

% Automatic initialization
:- initialization(start_computer_expert).