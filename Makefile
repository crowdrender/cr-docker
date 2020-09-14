cpu:
	docker build . --file Dockerfile --no-cache --tag cr:cpu
gpu:
	docker build . --file Dockerfile.cuda10 --no-cache --tag cr:gpu
