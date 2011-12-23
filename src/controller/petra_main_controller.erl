-module(petra_main_controller, [Req]).
-compile(export_all).


index('GET',[]) ->
    Services = boss_db:find(service,[]),
    {json,[{services,Services}]}.

