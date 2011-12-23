-module(petra_api_controller,[Req]).
-compile(export_all).

%% should these go in the model modules instead?
get_service(ServiceName) ->
    hd(boss_db:find(service,[{name,'equals',ServiceName}])).

service_exists(ServiceName) ->
    boss_db:count(service,[{name,'equals',ServiceName}]) > 0.

get_or_create_service(ServiceName) ->
    case service_exists(ServiceName) of
	false ->
	    Service = service:new(id,ServiceName),
	    {ok,SavedService} = Service:save(),
	    {created,SavedService};
	 true ->
	    {exists,get_service(ServiceName)}
    end.

get_item(ServiceName,ItemName) ->
    Service = get_service(ServiceName),
    hd(boss_db:find(item,[{name,'equals',ItemName},{service_id,'equals',Service:id()}])).
    
%% main controller functions
service('GET',[]) ->
    {output,"here"};
service('GET',[Name]) ->
    Service = get_service(Name),
    {json,Service:display_data()};
service('PUT',[Name]) ->
    {_Created,Service} = get_or_create_service(Name),
    {json,[{service,Service}]};
service('DELETE',[Name]) ->
    Service = get_service(Name),
    boss_db:delete(Service:id()),
    {output,"ok"};
service('GET',[Name,ItemName]) ->
    Item = get_item(Name,ItemName),
    {json, Item:display_data()};
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

%% an odd one out to handle "/"    
index('GET',[]) ->
    Services = boss_db:find(service,[]),
    {json,[{services,Services}]}.
