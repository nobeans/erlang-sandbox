-module(lib_misc).
-export([for/3, qsort/1, pythag/1, perms/1, max/2, filter/2, odds_and_evens_acc/1, sqrt/1]).

for(Max, Max, F) -> [F(Max)];
for(I, Max, F)   -> [F(I)|for(I+1, Max, F)].

qsort([]) -> [];
qsort([Pivot|T]) ->
    qsort([X || X <- T, X < Pivot])
    ++ [Pivot] ++
    qsort([X || X <- T, X >= Pivot]).

pythag(N) ->
    [{A,B,C} ||
        A <- lists:seq(1,N),
        B <- lists:seq(1,N),
        C <- lists:seq(1,N),
        A + B + C =< N,
        A*A + B*B =:= C*C
    ].

perms([]) -> [[]];
perms(L)  -> [[H|T] || H <- L, T <- perms(L--[H])].

max(X, Y) when X > Y -> X;
max(_, Y) -> Y.

filter(P, [H|T]) ->
    case P(H) of
        true -> [H|filter(P, T)];
        false -> filter(P, T)
    end;
filter(_, []) ->
    [].

odds_and_evens_acc(L) ->
    odds_and_evens_acc(L, [], []).

odds_and_evens_acc([H|T], Odds, Evens) ->
    case H rem 2 =:= 0 of
        true -> odds_and_evens_acc(T, Odds, [H|Evens]);
        false -> odds_and_evens_acc(T, [H|Odds], Evens)
    end;
odds_and_evens_acc([], Odds, Evens) ->
    {lists:reverse(Odds), lists:reverse(Evens)}.

sqrt(X) when X < 0 ->
    erlang:error({sqareRootNegativeArgument, X});
sqrt(X) ->
    math:sqrt(X).
