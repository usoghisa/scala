%% @author upisa01
%% @doc @todo Add description to temperature.


-module(temperature).
-export([temperatureConverter/0, displayTemperature/1]).

temperatureConverter() ->
 receive
	 {convertToFarrenheith, C} ->
		ResF = 32+C*9/5,
	 displayTemperature(ResF),
	 temperatureConverter();
	
	 {convertToCelsious, F} ->
		ResC = (F-32)*5/9,
	 displayTemperature(ResC),
	 temperatureConverter();
	 
	 {stop} ->
	 io:format("Stopping~n");
	 Other ->
	 io:format("Unknown: ~p~n", [Other]),
	 temperatureConverter()
 end.

displayTemperature(Res) ->
 	io:format("The temperature is converted to  : ~p~n", [Res]).

%% ====================================================================
%% 
%% ====================================================================
% 
% compile 	> c(temperature).
% start process > TemperAct = spawn(fun temperature:temperatureConverter/0).
% send msg > TemperAct ! {convertToFarrenheith, 32}.
% send msg > TemperAct ! {convertToCelsious, 100}.

% 
