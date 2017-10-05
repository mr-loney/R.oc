#!/usr/bin/ruby
ppp = "/Users/pengjun/Desktop/yy-svn/entmobile_ios_branches/entmobile-ios_6.6_LiveCommon_feature/aaaa.txt";

require 'pathname'
require 'xcodeproj'

SOURCE_ROOT = $*[0];

File.open(ppp,"w+").syswrite(SOURCE_ROOT);

# path_to_project = SOURCE_ROOT+"/"+PROJECT_NAME+".xcodeproj"
# project = Xcodeproj::Project.open(path_to_project)
# main_target = project.targets.first
# phase = main_target.new_shell_script_build_phase("R-OC Script")
# phase.shell_script = "ruby ${SRCROOT}/Pods/R-OC/R-OC/R-OC/BundleR.rb \"${SRCROOT}/${PROJECT_NAME}.xcodeproj\" \"${PROJECT_NAME}\""
# project.save()
