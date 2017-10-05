#!/usr/bin/ruby
require 'pathname'
require 'xcodeproj'

path_to_project = $*[0];

project = Xcodeproj::Project.open(path_to_project)
main_target = project.targets.first
phase = main_target.new_shell_script_build_phase("R-OC Script")
phase.shell_script = "ruby ${SRCROOT}/Pods/R-OC/R-OC/R-OC/BundleR.rb \"${SRCROOT}/${PROJECT_NAME}.xcodeproj\" \""+main_target+"\""
project.save()
