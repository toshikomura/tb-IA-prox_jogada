/*
The Mancala board looks something like this:
      b6 b5 b4 b3 b2 b1
   B                    A
      a1 a2 a3 a4 a5 a6

   We're going to represent it in form of a predicate

   mb(A, [A1, A2, ...], B, [B1, B2, ...]).

   whereby, the first and the third arguments represent the collected beats
   of each player, and the second and fourth arguments are lists representing
   the pits. Numbering is counter clock wise as depiected above.
*/

%% print_state(GIVEN_STATE).
%
%       print the board on the screen
%
print_state_list([X]) :- writef('%5r\n', [X]).
print_state_list([X|T]) :- writef('%5r\t', [X]), print_state_list(T).

print_state_tabs(1) :- writef('\t').
print_state_tabs(N) :- N1 is N-1, writef('\t'), print_state_tabs(N1).


print_state(mb(A, AL, B, BL)) :-
    length(AL, NPits),
    reverse(BL, RBL),
    writef('B\t'),
    print_state_list(RBL),
    writef('B%5r\t', [B]),
    print_state_tabs(NPits),
    writef('%5r A\n', [A]),
    writef('A\t'),
    print_state_list(AL),
    nl.


%%  Use a list of numbers [ A1, A2, ...., A6, A, B1, B2, ..., B6, B]
%
%
inc_by_one(N, [], N, []).
inc_by_one(0, LIST, 0, LIST).
inc_by_one(N, [H | T], LEFT, [HH | TT]) :-
    HH is H+1,
    NN is N-1,
    inc_by_one(NN, T, LEFT, TT).

sow_first(1, [H|T], LEFT, [0|MYL]) :- inc_by_one(H, T, LEFT, MYL).
sow_first(PIT, [H|T], LEFT, [H|MYL]) :-
    PIT>1,
    P is PIT-1,
    sow_first(P, T, LEFT, MYL).

%%% sow(PLAYER, STARTPIT, STARTCONFIG, ENDCONFIG)
%
% This predicate performs the actual move:
%  the first argument is the player (a or b),
%  the second argument is the number of the player's pit
%  the third argument is the Mancala board before the move,
%  the fourth argument is the Mancala board after the move
sow(a, PIT, mb(A, AL, B, BL), MB) :-
    sow_first(PIT, AL, LEFT, AL1),
    sow_repeat(a, LEFT, mb(A, AL1, B, BL), MB).
sow(b, PIT, mb(A, AL, B, BL), MB) :-
    sow_first(PIT, BL, LEFT, BL1),
    sow_repeat(b, LEFT, mb(A, AL, B, BL1), MB).

%% sow_repeat follows the first time of filling the players pits
sow_repeat(_, 0, MB, MB).
sow_repeat(a, HAND, mb(A, AL, B, BL), mb(Ae, ALe, B, BLe)) :-
    A1 is A+1, N is HAND-1,
    inc_by_one(N, BL, M, BL1),
    inc_by_one(M, AL, LEFT, AL1),
    sow_repeat(a, LEFT, mb(A1, AL1, B, BL1), mb(Ae, ALe, B, BLe)).
sow_repeat(b, HAND, mb(A, AL, B, BL), mb(A, ALe, Be, BLe)) :-
    B1 is B+1, N is HAND-1,
    inc_by_one(N, AL, M, AL1),
    inc_by_one(M, BL, LEFT, BL1),
    sow_repeat(a, LEFT, mb(A, AL1, B1, BL1), mb(A, ALe, Be, BLe)).

%% This predicate demonstrates a simple game loop.
%  run it from the goal prompt
%   ?- play_mancala.
%  Players a and b will be prompted to enter the pit number (1-6).
%  Remember to end the input with a "."
play_mancala :-
    MB = mb( 0, [ 4, 4, 4, 4, 4, 4], 0, [4, 4, 4, 4, 4, 4]),
    print_state(MB),
    player(a, MB).

player(a, mb(A, AL, B, _)) :-
    test_empty(AL),
    the_winner_is(A, B).
player(b, mb(A, _, B, BL)) :-
    test_empty(BL),
    the_winner_is(A, B).
player(a, MB) :-
    writef('Player A! Enter pit number: '),
    read(N),
    sow(a, N, MB, MB1),
    print_state(MB1),
    player(b, MB1).
player(b, MB) :-
    writef('Player B! Enter pit number: '),
    read(N),
    sow(b, N, MB, MB1),
    print_state(MB1),
    player(a, MB1).

test_empty([0]).
test_empty([0|L]) :- test_empty(L).

the_winner_is(A, A) :- !,
    writef('TIE! Both players have %w points.\n\n', [A]).
the_winner_is(A, B) :- A>B, !,
    writef('Player A wins with %w:%w!\n\n', [A, B]).
the_winner_is(A, B) :-
    writef('Player B wins with %w:%w!\n\n', [B, A]).

myloop :- myloop(0).

myloop(HELLOS) :-
    write('Enter a command (don\'t forget the ".") '),
    read(C),
    myproc(C, HELLOS).

myproc(hello, HELLOS) :- H is HELLOS+1,
    writef('Hello! (%w times)\n', [H]),
    myloop(H).
myproc(quit, _) :- write('Good Bye!'), nl.
myproc(X, HELLOS) :-
    writef('I don\'t know "%w".\n', [X]),
    myloop(HELLOS).
