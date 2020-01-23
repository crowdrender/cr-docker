import os
import bpy

version = "/CR/" + os.environ["CR_VERSION"] + ".zip"

bpy.ops.wm.addon_install(overwrite=True, filepath=version)
bpy.ops.wm.addon_enable(module='crowdrender')
bpy.ops.wm.save_userpref() 
exit()
