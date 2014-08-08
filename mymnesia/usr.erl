-module(usr).
-export([create_tables/0, ensure_loaded/0, write_record/0]). 
-export([add_usr/3, read_usr/1]).
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


add_usr(PhoneNo, CustId, Plan) when Plan==prepay; Plan==postpay -> 
    Rec = #usr{msisdn = PhoneNo, id = CustId, plan = Plan},
    Fun = fun() -> mnesia:write(Rec) end,
    {atomic, Res} = mnesia:transaction(Fun), 
    Res. 

read_usr(Oid) ->
    {atomic, Usr} = mnesia:transaction(fun() -> mnesia:read({usr, Oid}) end),
    Usr.
