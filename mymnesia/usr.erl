-module(usr).
-export([create_tables/0, ensure_loaded/0, write_record/0]). 
-export([add_usr/3, read_usr/1, delete_usr/1, set_service/3]).
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

delete_usr(CustId) ->
    F = fun() ->
             case mnesia:index_read(usr, CustId, id) of
                 [] ->
                      {error, instance};
                 [Usr] -> 
                     mnesia:delete({usr, Usr#usr.msisdn}) end
        end,
    {atomic, Result} = mnesia:transaction(F), Result.


set_service(CustId, Service, Flag) when Flag==true; Flag==false -> 
    Fun = fun() ->
                case mnesia:index_read(usr, CustId, id) of 
                    [] -> 
                        {error, instance};
                    [Usr] ->
                        Services = lists:delete(Service, Usr#usr.services), 
                        NewServices = case Flag of
                                          true -> [Service|Services];
                                          false -> Services 
                                      end,
                        mnesia:write(Usr#usr{services=NewServices}) end
        end,
    {atomic, Result} = mnesia:transaction(Fun), 
    Result.
