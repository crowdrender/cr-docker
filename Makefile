cpu:
	docker build . --file Dockerfile --tag cr:cpu

gpu:
	docker build . --file Dockerfile.cuda10 --tag cr:gpu
