-module(firstapp_sup).

-behaviour(supervisor).

%% API
-export([start_link/1]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type, Ar), {I, {I, start_link, Ar}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link(Arg) ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, [Arg]).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init(Argus) ->
	FirstappDB = ?CHILD(firstapp_db, worker, Argus),
    {ok, { {one_for_one, 5, 10}, [FirstappDB]}}.