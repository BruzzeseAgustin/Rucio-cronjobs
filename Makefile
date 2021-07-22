IMAGE := bruzzese/test
test:
	true
test_1:
        python ./.travis/json-validator.py --load_json ./rucio-sync-rses/docker/config/rse_repository.json
        cd ./rucio-sync-rses/docker
        docker-compose --file Dockerfile up -d --build

test_2:
        python ./.travis/json-validator.py --load_json ./rucio-sync-clients/docker/config/account_repository.json
        cd ./rucio-sync-clients/docker
        docker-compose --file Dockerfile up -d --build

image:
        docker build -t $(IMAGE) .

push-image:
        docker push $(IMAGE)


.PHONY: 
        image push-image test

