-module(usr).
-export([create_tables/0, ensure_loaded/0, write_record/0]). 

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


write_record() ->
    Rec = #usr{msisdn=700000003, id=3, status=enabled, plan=prepay, services=[data,sms,lbs]},
    mnesia:transaction(fun() -> mnesia:write(Rec) end).
