-module(to_string).
-export([atom_to_string/1]).


atom_to_string(Atom) ->
    atom_to_list(Atom).