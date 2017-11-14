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
require File.join(File.dirname(__FILE__), 'ROCFile')

# PATH = Pathname.new(File.dirname(__FILE__)).realpath.to_s.reverse
# NAME = PATH.split("/")[0].reverse
PROJECT = $*[0]
TARGET = $*[1]
FileHelper = ROCFile.new

@project = Xcodeproj::Project.open(PROJECT)

# 取出打包target
@target = nil
@project.targets.each do |target|
  if target.name.to_s == TARGET.to_s
    @target = target
    break
  end
end
raise 'target not found' unless @target

@AllResource = Array.new
@index = 0
files = @target.resources_build_phase.files.to_a.map do |pbx_build_file|
  pbx_build_file.file_ref.real_path.to_s

  # 取出所有打包资源
end.select do |path|
  unless @AllResource.include?(path)
    @AllResource[@index] = path
    @index += 1
  end
end

# 重新创建文件
FileHelper.reset

def read_bundle_with_project(bundle)
  bundle_target_name = bundle.gsub(/.bundle/, '')
  bundle_target = nil
  @project.targets.each do |target|
    if target.name.to_s == bundle_target_name.to_s
      bundle_target = target
      break
    end
  end
  raise 'bundle target not found' unless bundle_target
  FileHelper.bundle(bundle_target_name)

  bundle_resource = Array.new
  index = 0
  files = bundle_target.resources_build_phase.files.to_a.map do |pbx_build_file|
    pbx_build_file.file_ref.real_path.to_s
    # 取出所有打包资源
  end.select do |path|
    unless bundle_resource.include?(path)
      bundle_resource[index] = path
      index += 1
    end
  end

  bundle_resource.each do |path|
    # puts(path)
    resource_handle(bundle_target_name, path)
  end
end

def traverse_xcasssets_dir(bundle, file_path)
  f_name = File.basename(file_path)
  if f_name.end_with?('.colorset')
  elsif f_name.end_with?('.imageset')
    f_name = f_name.gsub(/imageset/, 'png')
    FileHelper.img(bundle, f_name)
  elsif f_name.end_with?('.dataset')
  elsif f_name.end_with?('.cubetextureset')
  elsif f_name.end_with?('.launchimage')
  elsif f_name.end_with?('.appiconset')
  else
      if File.directory? file_path
        Dir.foreach(file_path) do |file|
          if (file != '.') && (file != '..')
            traverse_xcasssets_dir(bundle, file_path + '/' + file)
            end
        end
      end
  end
end

def resource_handle(bundle, path)
  rs_name = File.basename(path)
  rs_name = rs_name.gsub(/@2x|@3x/, '@2x' => '', '@3x' => '')

  if rs_name.end_with?('.xib')
    FileHelper.xib(bundle, rs_name)
  elsif rs_name.end_with?('.png', '.tiff', '.jpg')
    FileHelper.img(bundle, rs_name)
  elsif rs_name.end_with?('.storyboard')
    FileHelper.storyboard(bundle, rs_name)
  elsif rs_name.end_with?('.xcassets')
    traverse_xcasssets_dir(bundle, path)
  elsif rs_name.end_with?('.bundle')
    if path.start_with?('${BUILT_PRODUCTS_DIR}/')
      read_bundle_with_project(rs_name)
    else
      puts(path)
    end
  else
    FileHelper.file(bundle, rs_name)
  end
  end

# 写文件
@AllResource.each do |path|
  resource_handle(nil, path)
end
