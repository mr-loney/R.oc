#!/usr/bin/ruby
# exec 'export LANG="en_US.UTF-8"'
# exec 'export LC_ALL="en_US.UTF-8"'
# exec 'export LANGUAGE="en_US.UTF-8'
# if RUBY_VERSION =~ /1.9/
#    Encoding.default_external = Encoding::UTF_8
#    Encoding.default_internal = Encoding::UTF_8
# end
require 'xcodeproj'

PROJECT = $*[0]
TARGET = $*[1]

ROOT = File.dirname(__FILE__);
setFile = [
  ROOT + "R.h",
  ROOT + "R.m",
  ROOT + "RBundle.h",
  ROOT + "RBundle.m",
  ROOT + "RImage.h",
  ROOT + "RImage.m",
  ROOT + "RXib.h",
  ROOT + "RXib.m",
  ROOT + "RStoryboard.h",
  ROOT + "RStoryboard.m",
  ROOT + "RFile.h",
  ROOT + "RFile.m"
];

setFile.each do |file_path|

end

@project = Xcodeproj::Project.open(PROJECT)
@target = nil
@project.targets.each do |target|
  if target.name.to_s == TARGET.to_s
    @target = target
    break
  end
end
raise 'target not found' unless @target

@project.files.each do |f|
  if f.is_a? Xcodeproj::Project::Object::PBXFileReference
    begin
      path = f.real_path.to_s;
      puts(path)
    end
  end
end
# files = @target.file_reference.files.to_a.map do |pbx_build_file|
#   pbx_build_file.file_ref.real_path.to_s
#
# end.select do |path|
#   unless @AllResource.include?(path)
#     @AllResource[@index] = path
#     @index += 1
#   end
# end
#
if project.is_a? Xcodeproj::Project::Object::PBXFileReference
  begin
    path = file.real_path.to_s;
    puts(path)
  #   if fullIgnoreList.include?(path)
  #     next;
  #   end
  #   #检查扩展名
  #   extName = File.extname(path).to_s().downcase();
  #   if( extNames .include?(extName) )
  #     if actionList.include?(path) == isInclude
  #       # puts("do "+isInclude.to_s);
  #       file.remove_from_project();
  #       if output
  #         output.push(path);
  #       end
  #     end
  #   end
  # rescue => exp
  #   puts(exp);
  end
end
