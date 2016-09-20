-module(firstapp_db).
-behaviour (gen_server).
-export([start_link/0, get/1, set/2, init/1, handle_call/3
			,handle_cast/2, handle_info/2, terminate/2, code_change/3]).

%% API

start_link() -> gen_server:start_link({local, ?MODULE}, ?MODULE, {}, []).

get(Key) -> 
	gen_server:call(?MODULE, {get, Key}).

set(Key, Value) ->
	gen_server:call(?MODULE, {set, Key, Value}).

%% Callbacks

init(_) ->
	{ok, ets:new(database, [set])}.

handle_call({get, Key}, _From, State) ->
	Reply = ets:lookup(State, Key),
	{reply, Reply, State};

handle_call({set, Key, Value}, _From, State) ->
	Reply1 = ets:insert(State, {Key, Value}),
	{reply, Reply1, State}.

handle_cast(_Msg, State) ->
	{noreply, State}.

handle_info(_Info, State) ->
	{noreply, State}.

code_change(_OldVsn, State, _Extra) ->
	{ok, State}.

terminate(_Reason, _State) ->
	ok.