-module(word_index).
-export([index/1]).
-define(Punctuation, "[,;\n\ ]").

index(File) ->
    Db = ets:new(indexTable, [ordered_set, named_table]),
    processFile(File),
    prettyIndex(),
    ets:delete(Db).


processFile(File) ->
    {ok, Io} = file:open(File, [read]),
    processLines(Io, 1).

processLines(Io, N) ->
    case io:get_line(Io, "") of
        eof ->
            ok;
        Line ->
            processLine(Line, N),
            processLines(Io, N+1)
    end.

processLine(Line, N) ->
    io:format("Processing line: ~s~n", [Line]),
    case re:split(Line, ?Punctuation) of
        [] ->
            io:format(">> No words found!~n"),
            [];
        Words ->
            processWords(Words, N)
    end.


normalise(Word) ->
    Word.
    %string:to_lower(Word).

storeAtPage(Word, N) ->
    io:format("Storing word: '~s' at page ~w~n", [Word, N]),
    ets:insert(indexTable, {{Word, N}}).

processWords([], _) ->
    ok;
processWords([Word|Rest], N) ->
    io:format("Found the word '~s' at page ~w ~n", [Word, N]),
    io:format("--------> Storing~n"),
    storeAtPage(normalise(Word), N),
    processWords(Rest, N).


prettyIndex() ->    
    io:format("=== Index ===~n"),
    case ets:first(indexTable) of
        '$end_of_table' ->
            io:format("End.~n"),
            ok;
        First ->
            io:format("First!~n"),
            case First of
                {Word, N} ->
                    io:format("~w~n", [{Word, [N]}]),
                    IndexEntry = {Word, [N]}
            end,
            prettyIndexNext(First,IndexEntry),
            io:format("Continue....~n")
    end.


prettyIndexNext(TabId, Entry) ->
    prettyIndexNext(TabId, Entry, {}).
prettyIndexNext(TabId, Entry, {Word, Lines} = IndexEntry) ->
    Next = ets:next(indexTable, Entry),
    case Next of
        '$end_of_table' ->
            prettyEntry(IndexEntry);
        {NextWord, M} ->
            if
                NextWord == Word ->
                    prettyIndexNext(Next, {Word, [M | Lines]});
                true ->
                    prettyIndex(IndexEntry),
                    prettyIndexNext(Next, {NextWord, [M]})
            end
    end.


prettyEntry(Entry) ->
    io:format("~w~n", [Entry]).
