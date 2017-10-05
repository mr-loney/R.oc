#!/usr/bin/ruby
exec 'export LANG="en_US.UTF-8"'
exec 'export LC_ALL="en_US.UTF-8"'
exec 'export LANGUAGE="en_US.UTF-8'
if RUBY_VERSION =~ /1.9/
   Encoding.default_external = Encoding::UTF_8
   Encoding.default_internal = Encoding::UTF_8
end

require 'pathname'
require 'xcodeproj'
@TAG_BEGIN = 'AUTO_PROPOTY_TAG_BEGIN'
@TAG_END = 'AUTO_PROPOTY_TAG_END'
@NORMAN_XCODE_TAG = '#define AUTO_PROPOTY_TAG_BEGIN
#define AUTO_PROPOTY_TAG_END
AUTO_PROPOTY_TAG_BEGIN
AUTO_PROPOTY_TAG_END'
@CURRENT_BUNDLE = 'mainBundle'
###########################################
def filename_adjust(name)
    f = name
    f = f.gsub(/\s+/,'_')# \[*.?+$^[](){}|\/]
    return f;
end
def img (name)
	t = name.split('.')
	name = t[0]
	suffix = t[1]
	fph = File.dirname(__FILE__) + "/RImage.h"
	fpm = File.dirname(__FILE__) + "/RImage.m"
	txtH = "@property (nonatomic,readonly) UIImage *"+filename_adjust(name)+";
    "
	txtM = "-(UIImage*)"+name+" { return [self img:@\""+name+"\" suffix:@\""+suffix+"\" bundle:[NSBundle "+@CURRENT_BUNDLE+"]]; }
    "

	writeOCFile(fph,txtH,fpm,txtM)
end
def xib (name)
	t = name.split('.')
	name = t[0]
	fph = File.dirname(__FILE__) + "/RXib.h"
	fpm = File.dirname(__FILE__) + "/RXib.m"
	txtH = "@property (nonatomic,readonly) UIView *"+filename_adjust(name)+";
    "
	txtM = "-(UIView*)"+name+" { return [[[NSBundle "+@CURRENT_BUNDLE+"] loadNibNamed:@\""+name+"\" owner:nil options:nil] firstObject]; }
    "

	writeOCFile(fph,txtH,fpm,txtM)
end
def file (name)
    t = name.split('.')
    name = t[0]
    suffix = t[1]
    if suffix == nil then
        return;
    end
    fph = File.dirname(__FILE__) + "/RFile.h"
    fpm = File.dirname(__FILE__) + "/RFile.m"
    name = filename_adjust(name);
    txtH = "@property (nonatomic,readonly) NSString *"+name+";
            @property (nonatomic,readonly) NSString *"+name+"_path;
    "
    txtM = "-(NSString*)"+name+" { return @\""+name+"\"; }
            -(NSString*)"+name+" { return [[NSBundle "+@CURRENT_BUNDLE+"] pathForResource:@\""+name+"\" ofType:@\""+suffix+"\"]; }
    "

    writeOCFile(fph,txtH,fpm,txtM)
end
def storyboard (name)
	t = name.split('.')
	name = t[0]
	fph = File.dirname(__FILE__) + "/RStoryboard.h"
	fpm = File.dirname(__FILE__) + "/RStoryboard.m"
	txtH = "@property (nonatomic,readonly) UIStoryboard *"+filename_adjust(name)+";
    "
	txtM = "-(UIStoryboard*)"+name+" { return [UIStoryboard storyboardWithName:@\""+name+"\" bundle:[NSBundle "+@CURRENT_BUNDLE+"]]; }
    "

	writeOCFile(fph,txtH,fpm,txtM)
end

def writeOCFile (f1,txt1,f2,txt2)
		breakTag = "
		"
		breakTag = ""
		#.h
		@htxt = Array.new
		@writeed = false
		@i = 0
		File.open(f1,"r") do |file|
			while line  = file.gets
				@htxt[@i] = line
				@i += 1

				if line.chop == @TAG_BEGIN then
					if !@writeed then
						@htxt[@i] = txt1
						@i += 1
						@writeed = true
					end
				end
			end
		end
		File.open(f1,"w+").syswrite(@htxt.join(breakTag))

		#.m
		@mtxt = Array.new
		@i = 0
		@writeed = false
		File.open(f2,"r") do |file|
			while line  = file.gets
				@mtxt[@i] = line
				@i += 1

				if line.chop == @TAG_BEGIN then
					if !@writeed then
						@mtxt[@i] = txt2
						@i += 1
						@writeed = true
					end
				end
			end
		end
		File.open(f2,"w+").syswrite(@mtxt.join(breakTag))
end

def newRImageFile ()
	fph = File.dirname(__FILE__) + "/RImage.h"
	fpm = File.dirname(__FILE__) + "/RImage.m"
		txtH = "#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RImage : NSObject
"+@NORMAN_XCODE_TAG+"
@end"
	txtM = "#import \"RImage.h\"
#import \"RImage+MemoryCache.h\"

@implementation RImage
"+@NORMAN_XCODE_TAG+"
@end"
	File.open(fph,"w+").syswrite(txtH)
	File.open(fpm,"w+").syswrite(txtM)
end

def newRXibFile ()
	fph = File.dirname(__FILE__) + "/RXib.h"
	fpm = File.dirname(__FILE__) + "/RXib.m"
		txtH = "#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RXib : NSObject
"+@NORMAN_XCODE_TAG+"
@end"
	txtM = "#import \"RXib.h\"

@implementation RXib
"+@NORMAN_XCODE_TAG+"
@end"
	File.open(fph,"w+").syswrite(txtH)
	File.open(fpm,"w+").syswrite(txtM)
end

def newRFileFile ()
    fph = File.dirname(__FILE__) + "/RFile.h"
    fpm = File.dirname(__FILE__) + "/RFile.m"
    txtH = "#import <Foundation/Foundation.h>
    #import <UIKit/UIKit.h>

    @interface RFile : NSObject
    "+@NORMAN_XCODE_TAG+"
    @end"
txtM = "#import \"RXib.h\"

@implementation RFile
"+@NORMAN_XCODE_TAG+"
@end"
File.open(fph,"w+").syswrite(txtH)
File.open(fpm,"w+").syswrite(txtM)
end

def newRStoryboardFile ()
	fph = File.dirname(__FILE__) + "/RStoryboard.h"
	fpm = File.dirname(__FILE__) + "/RStoryboard.m"
		txtH = "#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RStoryboard : NSObject
"+@NORMAN_XCODE_TAG+"
@end"
	txtM = "#import \"RStoryboard.h\"

@implementation RStoryboard
"+@NORMAN_XCODE_TAG+"
@end"
	File.open(fph,"w+").syswrite(txtH)
	File.open(fpm,"w+").syswrite(txtM)
end
###########################################

# PATH = Pathname.new(File.dirname(__FILE__)).realpath.to_s.reverse
# NAME = PATH.split("/")[0].reverse
PROJECT = $*[0];
TARGET = $*[1];

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
newRImageFile()
newRXibFile()
newRStoryboardFile()
newRFileFile()

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

    rs_name = File::basename(path)
    rs_name = rs_name.gsub(/@2x|@3x/, '@2x'=>'','@3x'=>'')

	if rs_name.end_with?(".xib") then
		xib(rs_name)
	elsif rs_name.end_with?(".png",".tiff",".jpg") then
		img(rs_name)
	elsif rs_name.end_with?(".storyboard") then
		storyboard(rs_name)
	elsif rs_name.end_with?(".xcassets") then
        traverse_xcasssets_dir(path)
    else
        file(rs_name)
	end
end
