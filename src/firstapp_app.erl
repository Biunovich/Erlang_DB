-module(firstapp_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    firstapp_sup:start_link(_StartArgs).

stop(_State) ->
    ok.
