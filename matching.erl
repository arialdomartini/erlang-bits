-module(matching).
-export([eval/1]).

eval({error, Message})->Message;
eval(success) -> "success".