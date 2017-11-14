#!/usr/bin/ruby
ppp = "/Users/pengjun/Desktop/github/R.oc/aaaa.txt";
require 'pathname'
require 'xcodeproj'

path_to_project = $*[0];

ENV.each do |e|
  File.open(ppp,"w+").syswrite(e);
end


File.open(ppp,"w+").syswrite(path_to_project);

# project = Xcodeproj::Project.open(path_to_project)
# main_target = project.targets.first
# phase = main_target.new_shell_script_build_phase("R-OC Script")
# phase.shell_script = "ruby ${SRCROOT}/Pods/R-OC/R-OC/R-OC/BundleR.rb \"${SRCROOT}/${PROJECT_NAME}.xcodeproj\" \""+main_target+"\""
# project.save()
