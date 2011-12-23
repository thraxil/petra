-module(petra_api_controller,[Req]).
-compile(export_all).

get_service(ServiceName) ->
    hd(boss_db:find(service,[{name,'equals',ServiceName}])).

get_item(ServiceName,ItemName) ->
    Service = get_service(ServiceName),
    hd(boss_db:find(item,[{name,'equals',ItemName},{service_id,'equals',Service:id()}])).
    

service('GET',[]) ->
    {output,"here"};
service('GET',[Name]) ->
    Service = get_service(Name),
    {json,[{service,Service}]};
service('PUT',[Name]) ->
    Service = service:new(id,Name),
    {ok,SavedService} = Service:save(),
    {json,[{service,SavedService}]};
service('DELETE',[Name]) ->
    {output,"ok"};
service('GET',[Name,ItemName]) ->
    Item = get_item(Name,ItemName),
    {json, [{item,Item}]};
service('PUT',[Name,ItemName]) ->
    Service = get_service(Name),
    Value = Req:post_param("value"),
    NewItem = item:new(id,ItemName,Value,Service:id()),
    {ok,SavedItem} = NewItem:save(),
    {json, [{item,SavedItem}]};
service('DELETE',[Name,ItemName]) ->
    Item = get_item(Name,ItemName),
    boss_db:delete(Item:id()),
    {output, "ok"}.
    
