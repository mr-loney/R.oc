#!/usr/bin/ruby
# exec 'export LANG="en_US.UTF-8"'
# exec 'export LC_ALL="en_US.UTF-8"'
# exec 'export LANGUAGE="en_US.UTF-8'
# if RUBY_VERSION =~ /1.9/
#    Encoding.default_external = Encoding::UTF_8
#    Encoding.default_internal = Encoding::UTF_8
# end

class ROCFile
   # 构造函数
   def initialize()
     @TAG_BEGIN = 'AUTO_PROPOTY_TAG_BEGIN'
     @TAG_END = 'AUTO_PROPOTY_TAG_END'
     @NORMAN_XCODE_TAG = '#define AUTO_PROPOTY_TAG_BEGIN
#define AUTO_PROPOTY_TAG_END
AUTO_PROPOTY_TAG_BEGIN
AUTO_PROPOTY_TAG_END'
   end

   def reset()
     newBundleFile()
     newRImageFile()
     newRXibFile()
     newRStoryboardFile()
     newRFileFile()
   end

   ###########################################
   def filename_adjust(name)
       f = name
       f = f.gsub(/\s+/,'_')# \[*.?+$^[](){}|\/]
       f = f.gsub(/-/,'_')
       if !f.gsub(/^[0-9]/,'').nil? then
         f = 'a'+f;
       end
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
   	txtM = "-(UIImage*)"+name+" { return [self img:@\""+name+"\" suffix:@\""+suffix+"\" bundle:self.bundle]; }
"

       imgExisted = propertyExisted(fph,txtH)
       if !imgExisted then
   	     writeOCFile(fph,txtH,fpm,txtM)
       end
   end

   def xib (name)
   	t = name.split('.')
   	name = t[0]
   	fph = File.dirname(__FILE__) + "/RXib.h"
   	fpm = File.dirname(__FILE__) + "/RXib.m"
   	txtH = "@property (nonatomic,readonly) UIView *"+filename_adjust(name)+";
"
   	txtM = "-(UIView*)"+name+" { return [[self.bundle loadNibNamed:@\""+name+"\" owner:nil options:nil] firstObject]; }
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
-(NSString*)"+name+" { return [self.bundle pathForResource:@\""+name+"\" ofType:@\""+suffix+"\"]; }
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
   	txtM = "-(UIStoryboard*)"+name+" { return [UIStoryboard storyboardWithName:@\""+name+"\" bundle:self.bundle]; }
"

   	writeOCFile(fph,txtH,fpm,txtM)
   end

      def propertyExisted (f1,txt1)
      		#.h
      		File.open(f1,"r") do |file|
      			while line  = file.gets
      				if line.gsub(/ /,'') == txt1.gsub(/ /,'') then
                return true;
      				end
      			end
      		end
          return false;
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
   				if line.chop.gsub(/ /,'') == @TAG_BEGIN then
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
          if line.chop.gsub(/ /,'') == @TAG_BEGIN then
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

   def newBundleFile ()
   	fph = File.dirname(__FILE__) + "/RBundle.h"
   	fpm = File.dirname(__FILE__) + "/RBundle.m"
   		txtH = "#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RBundle : NSObject
@end"
   	txtM = "#import \"RBundle.h\"

@implementation RBundle
@end"
   	File.open(fph,"w+").syswrite(txtH)
   	File.open(fpm,"w+").syswrite(txtM)
   end

   def newRImageFile ()
   	fph = File.dirname(__FILE__) + "/RImage.h"
   	fpm = File.dirname(__FILE__) + "/RImage.m"
   		txtH = "#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RImage : RBaseObject
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

@interface RXib : RBaseObject
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

@interface RFile : RBaseObject
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

@interface RStoryboard : RBaseObject
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
end
