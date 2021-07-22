IMAGE := bruzzese/
test:
	true
test_1:
	python ./.travis/json-validator.py --load_json ./rucio-sync-rses/docker/config/rse_repository.json
	cd ./rucio-sync-rses/docker
	docker-compose --file ./rucio-sync-rses/docker/Dockerfile up -d --build

test_2:
	python ./.travis/json-validator.py --load_json ./rucio-sync-clients/docker/config/account_repository.json
	cd ./rucio-sync-clients/docker
	docker-compose --file ./rucio-sync-clients/docker/Dockerfile up -d --build

image:
	docker build -t $(IMAGE) .

push-image:
	echo "$TRAVIS_BRANCH"
	docker push "$TRAVIS_BRANCH"/test:"$TRAVIS_BRANCH"


.PHONY: 
	image push-image test

