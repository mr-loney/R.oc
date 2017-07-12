#!/usr/bin/ruby
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
def img (name)
	t = name.split('.')
	name = t[0]
	suffix = t[1]
	fph = File.dirname(__FILE__) + "/RImage.h"
	fpm = File.dirname(__FILE__) + "/RImage.m"
	txtH = "@property (nonatomic,readonly) UIImage *"+name+";"
	txtM = "-(UIImage*)"+name+" { return [self img:@\""+name+"\" suffix:@\""+suffix+"\" bundle:[NSBundle "+@CURRENT_BUNDLE+"]]; }"

	writeOCFile(fph,txtH,fpm,txtM)
end
def xib (name)
	t = name.split('.')
	name = t[0]
	fph = File.dirname(__FILE__) + "/RXib.h"
	fpm = File.dirname(__FILE__) + "/RXib.m"
	txtH = "@property (nonatomic,readonly) UIView *"+name+";"
	txtM = "-(UIView*)"+name+" { return [[[NSBundle "+@CURRENT_BUNDLE+"] loadNibNamed:@\""+name+"\" owner:nil options:nil] firstObject]; }"

	writeOCFile(fph,txtH,fpm,txtM)
end
def storyboard (name)
	t = name.split('.')
	name = t[0]
	fph = File.dirname(__FILE__) + "/RStoryboard.h"
	fpm = File.dirname(__FILE__) + "/RStoryboard.m"
	txtH = "@property (nonatomic,readonly) UIStoryboard *"+name+";"
	txtM = "-(UIStoryboard*)"+name+" { return [UIStoryboard storyboardWithName:@\""+name+"\" bundle:[NSBundle "+@CURRENT_BUNDLE+"]]; }"

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
	name = File::basename(path)
	name = name.gsub(/@2x|@3x/, '@2x'=>'','@3x'=>'')
	if !@AllResource.include?(name) then
		@AllResource[@index] = name
		@index += 1
	end
end

#重新创建文件
newRImageFile()
newRXibFile()
newRStoryboardFile()

#写文件
@AllResource.each do |rs|
	rs_name = File.basename(rs)
	if rs.end_with?(".xib") then
		xib(rs_name)
	elsif rs.end_with?(".png",".tiff",".jpg") then
		img(rs_name)
	elsif rs.end_with?(".storyboard") then
		storyboard(rs_name)
	elsif rs.end_with?(".xcassets") then

	end
end
