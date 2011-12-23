#!/bin/sh
cd `dirname $0`
exec erl -pa $PWD/ebin \
     -pa /home/anders/code/erlang/ChicagoBoss-0.6.9/ebin \
     -pa /home/anders/code/erlang/ChicagoBoss-0.6.9/deps/*/ebin \
     -boss developing_app petra \
     -boot start_sasl -config boss -s reloader -s boss \
     -sname wildbill
