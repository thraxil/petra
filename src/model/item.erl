-module(item,[Id,Name,Value,ServiceId]).
-compile(export_all).

-belongs_to(service).

%% for the web api, we don't need to expose internal ids
display_data() ->
    [{name,Name},{value,Value}].
