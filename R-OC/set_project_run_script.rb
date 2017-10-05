#!/usr/bin/ruby
ppp = "/Users/pengjun/Desktop/yy-svn/entmobile_ios_branches/entmobile-ios_6.6_LiveCommon_feature/aaaa.txt";

require 'pathname'
require 'xcodeproj'

current_pwd="$PWD"
project_dir=`cd "../../"; pwd`
# cd "$current_pwd"

File.open(ppp,"w+").syswrite(project_dir);#HOME + " 6 "+ PATH);

# Get .xcodeproj file path (yes I know it's not a file)
# project_file=`find "$project_dir" -maxdepth 1 -name "*.xcodeproj" | tail -1`
#
# SOURCE_ROOT = $*[0];
# PROJECT_NAME = $*[1];
#
# path_to_project = SOURCE_ROOT+"/"+PROJECT_NAME+".xcodeproj"
# project = Xcodeproj::Project.open(path_to_project)
# main_target = project.targets.first
# phase = main_target.new_shell_script_build_phase("R-OC Script")
# phase.shell_script = "ruby ${SRCROOT}/Pods/R-OC/R-OC/R-OC/BundleR.rb \"${SRCROOT}/${PROJECT_NAME}.xcodeproj\" \"${PROJECT_NAME}\""
# project.save()
