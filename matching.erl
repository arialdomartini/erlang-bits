-module(matching).
-export([eval/1]).

eval({error, Message})->Message;
eval(success) -> "success";
eval(Animal) -> 
    case Animal of
        "elephant" -> dumbo;
        _ -> "Some other animal"
    end.