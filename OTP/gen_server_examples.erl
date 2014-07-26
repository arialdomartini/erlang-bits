-module(gen_server_examples).
-export([start_link/1]).
-export([init/1]).

start_link(Filename) ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, Filename, []).

init(Filename) ->
    usr_db:create_tables(Filename),
    usr_db:restore_backup(),
    {ok, null}.



