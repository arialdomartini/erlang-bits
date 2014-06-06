-module(record1).
-export([test1/0, test2/0]).
-record(person, {name, age, phone}).
-record(name, {first, surname}).

test1() ->
    Person = joe(),
    showPerson(Person),
    showPerson(birthday(Person)).


test2() ->
    Person = anne(),
    showPerson(Person),
    showPerson(birthday(Person)).


joe() ->
    #person{name = #name{first = "Joe", surname = "Capioca"},  age = 21, phone ="0573-278271"}.

anne() ->
    #person{name = #name{first = "Anne", surname = "Giannetti"},  age = 71, phone = "0573/892028"}.

birthday(#person{age=Age, name="Joe"} = Person) ->
    Person#person{age = Age + 1};
birthday(#person{} = Person) ->
    Person.

showPerson(Person) ->
    io:format("firstname: ~p, secondname: ~p,  age: ~p, phone: ~p~n", [(Person#person.name)#name.first, (Person#person.name)#name.surname, Person#person.age, Person#person.phone]).

