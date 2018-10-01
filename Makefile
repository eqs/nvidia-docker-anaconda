
PROJECT_NAME=my_project
JUPYTER_PORT=8888
IMAGE_NAME=$(PROJECT_NAME)-image
CONTAINER_NAME=$(PROJECT_NAME)-container

docker-build:
	docker build -t $(IMAGE_NAME) -f docker/Dockerfile .

docker-run:
	docker run -it --rm --runtime=nvidia \
		--name $(CONTAINER_NAME) \
		-p $(JUPYTER_PORT):$(JUPYTER_PORT) \
		-v `pwd`:/work \
		$(IMAGE_NAME) \
		/bin/bash
jupyter:
	jupyter lab --ip=0.0.0.0 --allow-root --port=$(JUPYTER_PORT) \
		--NotebookApp.token='nvidia-docker-anaconda' \
		--NotebookApp.terminado_settings='{"shell_command": ["/bin/bash"]}'

