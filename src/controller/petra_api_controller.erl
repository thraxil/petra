-module(petra_api_controller,[Req]).
-compile(export_all).

service('GET',[]) ->
    {output,"here"};
service('GET',[Name]) ->
    Services = boss_db:find(service,[{name,'equals',Name}]),
    {json,[{service,hd(Services)}]};
service('PUT',[Name]) ->
    Service = service:new(id,Name),
    {ok,SavedService} = Service:save(),
    {json,[{service,SavedService}]};
service('DELETE',[Name]) ->
    {output,"ok"};
service('GET',[Name,ItemName]) ->
    {output, "service: " ++ Name ++ " Item: " ++ ItemName};
service('PUT',[Name,ItemName]) ->
    {output, "ok"};
service('DELETE',[Name,ItemName]) ->
    {output, "ok"}.
    
