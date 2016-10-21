%% @author Matthew.Mills
%% @doc @todo Add description to tdd.


-module(tdd).

%% ====================================================================
%% API functions
%% ====================================================================
-export([test/0, add/1]).

test() -> 
	0 = add(""),
	1 = add("1"),
	3 = add("1,2"),
	6 = add("1,2,3"),
	6 = add("1,2\n3"),
	6 = add("//;\n1;2;3"),
	error = add("-1,3"),
	ok.

add([]) -> 0;
add([$/, $/, Delimiter, $\n | String]) -> Tokens = tokenize(String, Delimiter),
										 lists:sum(lists:map(fun(X) -> to_number(X) end, Tokens));
add(String) -> 	Tokens = tokenize(String, ",|\n"),
				lists:sum(lists:map(fun(X) -> to_number(X) end, Tokens)).

%% ====================================================================
%% Internal functions
%% ====================================================================
tokenize(String, Delimiter) -> re:split(String, [Delimiter], [{return, list}]).

to_number(String) -> case string:to_integer(String) of
{Int, _} when Int < 0 -> throw(invalid_number);
{Int, _} -> Int
end.