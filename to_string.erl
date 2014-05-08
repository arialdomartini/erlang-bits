-module(to_string).
-export([atom_to_string/1, string_to_atom/1, string_to_existing_atom/1, string_to_tuple/1]).


atom_to_string(Atom) ->
    atom_to_list(Atom).

string_to_atom(String) ->
    list_to_atom(String).

string_to_existing_atom(String) ->
    list_to_existing_atom(String).

string_to_tuple(String) ->
    list_to_tuple(String).