import optparse, sys
import bpy

args = sys.argv[sys.argv.index("--") + 1:]


# add arguments for installing and enabling the addon
parser = optparse.OptionParser()
# add option to install an addon from a file
parser.add_option('-i', "--install", action="store_true", dest="install")
parser.add_option("-e", "--enable", action="store_false", dest="install")
# add an option arg for the file path of the addon to be installed
parser.add_option("-f", "--file", action="store", type="string", dest="filename")


(options, cl_args) = parser.parse_args(args)
print(f"Parsed options {options} and args {cl_args}.")
# if the install method has been called...
if options.install:
    print(f"Installing Blender from {options.filename}")
    bpy.ops.preferences.addon_install(overwrite=True, filepath=options.filename)
    
print("Enabling the crowdrender module...")
bpy.ops.preferences.addon_enable(module='crowdrender')
print("Saving blender preferences...")
bpy.ops.wm.save_userpref() 
print("FINISHED installing/enabling Crowdrender.")
