-module(firstapp).
-export([start/0]).

start() -> application:start(firstapp).