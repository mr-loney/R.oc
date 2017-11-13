#!/usr/bin/ruby
# exec 'export LANG="en_US.UTF-8"'
# exec 'export LC_ALL="en_US.UTF-8"'
# exec 'export LANGUAGE="en_US.UTF-8'
# if RUBY_VERSION =~ /1.9/
#    Encoding.default_external = Encoding::UTF_8
#    Encoding.default_internal = Encoding::UTF_8
# end

require 'pathname'
require 'xcodeproj'
require File.join(File.dirname(__FILE__),'ROCFile')

# PATH = Pathname.new(File.dirname(__FILE__)).realpath.to_s.reverse
# NAME = PATH.split("/")[0].reverse
PROJECT = $*[0];
TARGET = $*[1];
FileHelper = ROCFile.new();

project = Xcodeproj::Project.open(PROJECT)

#取出打包target
@target = nil
project.targets.each do |target|
	if target.name.to_s == TARGET.to_s then
		@target = target
		break
	end
end
if !@target then
	raise 'target not found'
end

@AllResource = Array.new
@index = 0
files = @target.resources_build_phase.files.to_a.map do |pbx_build_file|
		pbx_build_file.file_ref.real_path.to_s

#取出所有打包资源
end.select do |path|
	if !@AllResource.include?(path) then
        @AllResource[@index] = path
		@index += 1
	end
end

#重新创建文件
FileHelper.reset();

def traverse_xcasssets_dir(file_path)
    f_name = File::basename(file_path)
    if f_name.end_with?(".colorset") then
    elsif f_name.end_with?(".imageset") then
        f_name = f_name.gsub(/imageset/, 'png')
        img(f_name)
    elsif f_name.end_with?(".dataset") then
    elsif f_name.end_with?(".cubetextureset") then
    elsif f_name.end_with?(".launchimage") then
    elsif f_name.end_with?(".appiconset") then
    else
        if File.directory? file_path
            Dir.foreach(file_path) do |file|
                if file !="." and file !=".."
                    traverse_xcasssets_dir(file_path+"/"+file)
                end
            end
        else
    end
    end

end
#写文件
@AllResource.each do |path|
#puts(path)
    rs_name = File::basename(path)
    rs_name = rs_name.gsub(/@2x|@3x/, '@2x'=>'','@3x'=>'')

	if rs_name.end_with?(".xib") then
		FileHelper.xib(rs_name)
	elsif rs_name.end_with?(".png",".tiff",".jpg") then
		FileHelper.img(rs_name)
	elsif rs_name.end_with?(".storyboard") then
		FileHelper.storyboard(rs_name)
	elsif rs_name.end_with?(".xcassets") then
        traverse_xcasssets_dir(path)
    else
        FileHelper.file(rs_name)
	end
end
