#!/usr/bin/ruby

require 'pathname'
require 'xcodeproj'

ppp = "/Users/pengjun/Desktop/yy-svn/entmobile_ios_branches/entmobile-ios_6.6_LiveCommon_feature/aaaa.txt";

path_to_project = "${SOURCE_ROOT}/${PROJECT_NAME}.xcodeproj"
# project = Xcodeproj::Project.open(path_to_project)
# main_target = project.targets.first
# phase = main_target.new_shell_script_build_phase("Name of your Phase")
# phase.shell_script = "do sth with ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/your.file"
# project.save()

File.open(ppp,"w+").syswrite(path_to_project);#HOME + " 6 "+ PATH);
# puts(ROOT_PATH)
# if File.directory? ROOT_PATH
#     Dir.foreach(ROOT_PATH) do |file|
#         if file.end_with?(".xcodeproj")
#
#         end
#         puts(file)
#     end
# else
# project = Xcodeproj::Project.open(PROJECT)
#
# #取出打包target
# @target = nil
# project.targets.each do |target|
# 	if target.name.to_s == TARGET.to_s then
# 		@target = target
# 		break
# 	end
# end
# if !@target then
# 	raise 'target not found'
# end
