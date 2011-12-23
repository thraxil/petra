-module(petra_main_controller, [Req]).
-compile(export_all).
-default_action(index).

index('GET',[]) ->
    Services = boss_db:find(service,[]),
    {json,[{services,Services}]}.
