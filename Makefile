cpu:
	docker build . --file Dockerfile --tag cr:cpu --build-arg BL_VERSION_SHORT="${BLENDER_VERSION_STRING}"

gpu:
	docker build . --file Dockerfile.cuda10 --tag cr:gpu
