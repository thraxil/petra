ERL=erl
APP=petra

all:
	$(ERL) -pa /home/anders/code/erlang/ChicagoBoss-0.6.9/ebin -eval 'boss_load:load_all_modules_and_emit_app_file($(APP), "ebin")' -s init stop -noshell

clean:
	rm -fv ebin/*.beam
	rm -fv ebin/$(APP).app
	
update_po:
	$(ERL) -pa ebin -pa ../ChicagoBoss/ebin -eval 'boss_load:load_models("ebin")' -eval 'boss_lang:update_po()' -s init stop -noshell

.PHONY: test
test:
	$(ERL) -pa $(PWD)/ebin -pa /home/anders/code/erlang/ChicagoBoss-0.6.9/ebin -run boss_web_test start $(APP) -noshell
