import os
import bpy

version = "/CR/" + os.environ["CR_VERSION"] + ".zip"

bpy.ops.preferences.addon_install(overwrite=True, filepath=version)
bpy.ops.preferences.addon_enable(module='crowdrender')
bpy.ops.wm.save_userpref() 
exit()
