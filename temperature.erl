%% @author upisa01
%% @doc @todo Add description to temperature.


-module(temperature).
-export([temperatureConverter/0, displayTemperature/1]).

temperatureConverter() ->
 receive
	 {convertToFarrenheith, C} ->
		ResC = 32+C*9/5,
	 % io:format("~p C is ~p F~n", [C, 32+C*9/5]),
	 displayTemperature(ResC),
	 temperatureConverter();
	 
	 {convertToCelsious, F} ->
		ResF = (F-32)*5/9,
	 % io:format("~p F is ~p C~n", [F, (F-32)*5/9]),
	 displayTemperature(ResF),
	 temperatureConverter();
	 
	 {stop} ->
	 io:format("Stopping~n");
	 Other ->
	 io:format("Unknown: ~p~n", [Other]),
	 temperatureConverter()
 end.

displayTemperature(Res) ->
 	io:format("Print : ~p~n", [Res]).

%% ====================================================================
%% P1 = spawn(person, init, ["aaa"]),
%% ====================================================================
% 
% c(temperature).
% temperAct = spawn(fun temperature:temperatureConverter/0).
% temperAct = spawn(temperature,temperatureConverter,[]).
% temperAct ! {convertToFarrenheith, 32}.
% temperAct ! {convertToCelsious, 100}.
% 
