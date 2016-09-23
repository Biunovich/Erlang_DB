-module (firstapp_client).
-export ([send/1]).

send(Term) ->
	{ok, Socket} = gen_tcp:connect("localhost", 1337, [binary, {packet, 4}]),
	ok = gen_tcp:send(Socket, term_to_binary(Term)),
	receive 
		{tcp, Socket, Bin} ->
			Str = binary_to_term(Bin),
			io:format("~p~n", [Str]),
			gen_tcp:close(Socket)
	end.
