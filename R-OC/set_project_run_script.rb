#!/usr/bin/ruby

require 'pathname'
require 'xcodeproj'

File.open("/Users/pengjun/Desktop/yy-svn/entmobile_ios_branches/entmobile-ios_6.6_LiveCommon_feature/aaaa.txt"),"w+").syswrite("啦啦啦啦");
puts('啦啦啦啦')
puts(File.dirname(__FILE__))
ROOT_PATH = File.join(File.dirname(__FILE__),"../../");
puts(ROOT_PATH)
if File.directory? ROOT_PATH
    Dir.foreach(ROOT_PATH) do |file|
        if file.end_with?(".xcodeproj")

        end
        puts(file)
    end
else
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
