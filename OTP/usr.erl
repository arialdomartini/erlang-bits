-export([start_link/0, start_link/1, stop/0]).
-export([init/1, terminate/2, handle_call/3, handle_cast/2]).
-export([add_usr/3, delete_usr/1, set_service/3, set_status/2, delete_disabled/0, lookup_id/1]).
-export([lookup_msisdn/1, service_flag/2]).

-behavior(gen_server).

-include("usr.hrl").


% Maintenance API
start_link() ->
    start_link("usrDb");
start_link(Filename) ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, Filename, []}).

stop() ->
    gen_server:cast(?MODULE, stop).


% Customer API
add_usr(PhoneNumber, CustomerId, Plan) when Plan == prepay; Plan == postpay->
    gen_server:call(?MODULE, {add_usr, PhoneNumber, CustomerId, Plan}).

delete_usr(CustomerId) ->
    gen_server:call(?MODULE, {delete_usr, CustomerId}).

set_service(CustomerId, Service, Flag) when Flag == true; Flag == false ->
    gen_server:call(?MODULE, {set_service, CustomerId, Service, Flag}).

set_status(CustomerId, Status) when Status == enables; Status == disabled->
    gen_server:call(?MODULE, {set_status, CustomerId, Status}).

delete_disable() ->
    gen_server:call(?MODULE, delete_disable).

lookup_id(CustomerId) ->
    usr_db:lookup_id(CustomerId).


% Service API
lookup_msisdn(PhoneNumber) ->
    usr_db:lookup_msisdn(PhoneNumber).


