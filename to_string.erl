-module(to_string).
-export([atom_to_string/1, string_to_atom/1]).


atom_to_string(Atom) ->
    atom_to_list(Atom).

string_to_atom(String) ->
    list_to_atom(String).