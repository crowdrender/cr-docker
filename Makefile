cpu:
	docker build . --file Dockerfile --tag blender-plugin:cpu

gpu:
	docker build . --file Dockerfile.Cuda --tag blender-plugin:gpu
