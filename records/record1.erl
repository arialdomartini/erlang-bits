-module(record1).
-export([test1/0, test2/0]).
-record(person, {name, age, phone}).

test1() ->
    showPerson(joe()).

test2() ->
    showPerson(birthday(joe())).

joe() ->
    #person{name = "Joe", age = 21, phone ="0573-278271"}.

birthday(Person = #person{age=Age} ) ->
    Person#person{age = Age + 1}.

showPerson(Person) ->
    io:format("name: ~p, age: ~p, phone: ~p", [Person#person.name, Person#person.age, Person#person.phone]).

