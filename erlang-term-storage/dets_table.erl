-module(dets_table).
-export([run/0]).

run() ->
    dets:open_file(food, [{type, bag}, {file, "./food.table"}]),
    dets:insert(food, {italy, spaghetti}),
    dets:insert(food, {sweden, meatballs}),
    dets:insert(food, {italy, pizza}),

    % I suppose Erlang r16 changed the fun2ms API...
    NotItalian = ets:fun2ms(fun({Loc, Food}) when Loc /= italy -> Food end),
    NotItalian.
                   
    
