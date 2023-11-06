import argparse
import os

# blender imports
import bpy


# add arguments for installing and enabling the addon
parser = argparse.ArgumentParser()
# add option to install an addon from a file
parser.add_argument("-i", "--install_from_file", action="store", dest="filepath")
# add an option arg for the file path of the addon to be installed

(args, cl_args) = parser.parse_known_args()

print(f"Parsed options {args} and args {cl_args}.")

# if a file path is provided...
if args.filepath is not None and os.path.exists(args.filepath):
    # ask blender to install from the file given
    print(f"Installing Blender from {args.filepath}")
    bpy.ops.preferences.addon_install(overwrite=True, filepath=args.filepath)

print("Enabling the crowdrender module...")
bpy.ops.preferences.addon_enable(module="crowdrender")

if hasattr(bpy.ops.crowdrender, "install_deps"):
    bpy.ops.crowdrender.install_deps()

print("Saving blender preferences...")
bpy.ops.wm.save_userpref()
print("FINISHED installing/enabling Crowdrender.")
