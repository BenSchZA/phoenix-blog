update:
	mix deps.get
	cd assets && npm install

setup:
	mix local.hex --if-missing
	mix archive.install hex phx_new 1.4.10
	mix deps.get
	cd assets && npm install

start:
	MIX_ENV=dev mix phx.server

deploy:
	docker-compose build && docker-compose push

release:
	mix local.hex --force && mix local.rebar --force
	mix deps.get --only prod
	mix deps.compile
	cd assets && npm install && npm run deploy
	mix phx.digest
	mix compile
	mix release

cookie:
	cat _build/prod/rel/app/releases/COOKIE
