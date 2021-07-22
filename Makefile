
## ====================
## CI tasks
## ====================
test_rses:
	export TEST_ENV=true
	python ./.travis/json-validator.py --load_json ./rucio-sync-rses/docker/config/rse_repository.json
	cd ./rucio-sync-rses/docker
	docker-compose --file ./rucio-sync-rses/docker/Dockerfile up -d --build

test_clients:
	python ./.travis/json-validator.py --load_json ./rucio-sync-clients/docker/config/account_repository.json
	cd ./rucio-sync-clients/docker
	docker-compose --file ./rucio-sync-clients/docker/Dockerfile up -d --build

test_fts:
	cd ./fts-renew/docker
	docker-compose --file ./fts-renew/docker/config/Dockerfile up -d --build

test_hermes2:
	cd ./rucio-add-hermes2/docker
	docker-compose --file ./rucio-add-hermes2/docker/Dockerfile up -d --build

test_admin:
	cd ./rucio-pic-admin/docker
	docker-compose --file ./rucio-pic-admin/docker/Dockerfile up -d --build

test_monitoring:
	cd ./rucio-pic-monitoring/docker
	docker-compose --file ./rucio-pic-monitoring/docker/Dockerfile up -d --build

## =====================
## PUSH tasks
## =====================
push-image:
	echo $(TEST_ENV)
	echo $(TRAVIS_BRANCH)
	docker push $(IMAGE)/${REPO_NAME}:$(TRAVIS_BRANCH)

.PHONY: 
	image push-image test

