IMAGE := bruzzese

## ====================
## CI tasks
## ====================
test_rses:
	python ./.travis/json-validator.py --load_json ./rucio-sync-rses/docker/config/rse_repository.json
	cd ./rucio-sync-rses/docker
	docker-compose --file ./rucio-sync-rses/docker/Dockerfile up -d --build
	REPO_NAME=rucio-sync-rses
test_clients:
	python ./.travis/json-validator.py --load_json ./rucio-sync-clients/docker/config/account_repository.json
	cd ./rucio-sync-clients/docker
	docker-compose --file ./rucio-sync-clients/docker/Dockerfile up -d --build
	REPO_NAME=rucio-sync-clients
test_fts:
	cd ./fts-renew/docker
	docker-compose --file ./fts-renew/docker/config/Dockerfile up -d --build
	REPO_NAME=fts-renew
test_hermes2:
	cd ./rucio-add-hermes2/docker
	docker-compose --file ./rucio-add-hermes2/docker/Dockerfile up -d --build
	REPO_NAME=add-hermes-2
test_admin:
	cd ./rucio-pic-admin/docker
	docker-compose --file ./rucio-pic-admin/docker/Dockerfile up -d --build
	REPO_NAME=rucio-admin
test_monitoring:
	cd ./rucio-pic-monitoring/docker
	docker-compose --file ./rucio-pic-monitoring/docker/Dockerfile up -d --build
	REPO_NAME=rucio-admin-monitoring


## =====================
## PUSH tasks
## =====================
push-image:
	echo $(TRAVIS_BRANCH)
	docker push $(IMAGE)/$(REPO_NAME):$(TRAVIS_BRANCH)

.PHONY: 
	image push-image test

