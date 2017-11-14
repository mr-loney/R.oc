#!/usr/bin/ruby
ppp = "/Users/pengjun/Desktop/github/R.oc/aaaa.txt";
require 'pathname'
require 'xcodeproj'

current_pwd="$PWD"
project_dir=`cd "../../"; pwd`
cd "$current_pwd"

path_to_project=`find "$project_dir" -maxdepth 1 -name "*.xcodeproj" | tail -1`


# path_to_project = $*[0];

File.open(ppp,"w+").syswrite(path_to_project);

# project = Xcodeproj::Project.open(path_to_project)
# main_target = project.targets.first
# phase = main_target.new_shell_script_build_phase("R-OC Script")
# phase.shell_script = "ruby ${SRCROOT}/Pods/R-OC/R-OC/R-OC/BundleR.rb \"${SRCROOT}/${PROJECT_NAME}.xcodeproj\" \""+main_target+"\""
# project.save()
