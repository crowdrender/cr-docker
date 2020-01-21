import bpy

cuda_devices, opencl_devices = bpy.context.preferences.addons['cycles'].preferences.get_devices()

print()
print("found following CUDA devices:")
print(cuda_devices)
#print(opencl_devices)

bpy.context.preferences.addons['cycles'].preferences.compute_device_type = 'CUDA'
for device in bpy.context.preferences.addons['cycles'].preferences.devices:
	device.use = True

bpy.ops.wm.save_userpref() 
exit()
