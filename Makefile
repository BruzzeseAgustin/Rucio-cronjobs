IMAGE := bruzzese/
test:
	true
test_rses:
	python ./.travis/json-validator.py --load_json ./rucio-sync-rses/docker/config/rse_repository.json
	cd ./rucio-sync-rses/docker
	docker-compose --file ./rucio-sync-rses/docker/config/Dockerfile up -d --build

test_clients:
	python ./.travis/json-validator.py --load_json ./rucio-sync-clients/docker/config/account_repository.json
	cd ./rucio-sync-clients/docker
	docker-compose --file ./rucio-sync-clients/docker/config/Dockerfile up -d --build

test_fts:
	cd ./fts-renew/docker
	docker-compose --file ./fts-renew/docker/config/Dockerfile up -d --build

test_hermes2:
	cd ./rucio-add-hermes2/docker
	docker-compose --file ./rucio-add-hermes2/docker/config/Dockerfile up -d --build

test_admin:
	cd ./rucio-pic-admin/docker
	docker-compose --file ./rucio-pic-admin/docker/config/Dockerfile up -d --build

test_monitoring:
	cd ./rucio-pic-monitoring/docker
	docker-compose --file ./rucio-pic-monitoring/docker/config/Dockerfile up -d --build

image:
	docker build -t $(IMAGE) .

push-image:
	echo $TRAVIS_BRANCH
	docker push $IMAGE/test:$TRAVIS_BRANCH


.PHONY: 
	image push-image test

