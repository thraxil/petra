I'm learning Erlang and Chicago Boss. Cut me some slack.

As a quick test project, I'm trying to do a fairly close port of my
old "pita" microapp to CB:

  http://code.google.com/p/microapps/wiki/Pita

It's basically the same interface, though I'm having a bit of trouble
mapping CB's routes to exactly the same URL patterns as I had with
TG. So, instead of:

    /service/foo/

It has to be 

    /api/service/foo/

and instead of 

    /service/foo/item/bar/

it is

    /api/service/foo/bar/

I'm also tending towards having it return slightly more verbose JSON
rather than simple text. So with Pita:

    GET /service/foo/item/bar/
    -> some value that's been stored

Petra will instead do:

    GET /api/service/foo/bar/
    {"name" : "bar", "value" : "some value that's been stored"}

I'll probably have this switch out on Accept headers soon though.

Please help me learn to write better Erlang and CB code by sending me
helpful comments or pull requests with improvements.
