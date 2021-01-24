app_name = image_webifier

debug:
	docker attach $(app_name)

console:
	echo -ne "\033]0;In $(app_name) console\007" && irb

run:
	echo -ne "\033]0;$(app_name)\007" && docker-compose up

build_and_run:
	echo -ne "\033]0;$(app_name)\007" && docker-compose up --build

to_container:
	echo -ne "\033]0;$(app_name)\007" && docker exec -it $(app_name) bash