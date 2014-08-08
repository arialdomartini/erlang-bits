-module(usr).
-export([create_tables/0, ensure_loaded/0]). 

-include("usr.hrl").


create_tables() ->
    mnesia:create_table(usr, 
                        [{disc_copies, [node()]}, 
                         {ram_copies, nodes()},
                         {type, set}, 
                         {attributes,record_info(fields, usr)}, 
                         {index, [id]}]).
ensure_loaded() ->
    ok = mnesia:wait_for_tables([usr], 60000).
