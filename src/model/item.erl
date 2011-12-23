-module(item,[Id,Name,Value,ServiceId]).
-compile(export_all).

-belongs_to(service).
