-module(service,[Id,Name]).
-compile(export_all).

-has({items, many}).

display_data() ->
    [{name,Name},{items,[Item:display_data() || Item <- THIS:items()]}].
