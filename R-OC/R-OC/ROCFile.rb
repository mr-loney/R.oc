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
  def initialize
    @PROPERTY_BEGIN = 'AUTO_PROPOTY_TAG_BEGIN'
    @PROPERTY_END = 'AUTO_PROPOTY_TAG_END'
    @SET_PROPERTY_TAG = '#define AUTO_PROPOTY_TAG_BEGIN
#define AUTO_PROPOTY_TAG_END
AUTO_PROPOTY_TAG_BEGIN
AUTO_PROPOTY_TAG_END'
    @CLASS_BEGIN = 'AUTO_CLASS_TAG_BEGIN'
    @CLASS_END = 'AUTO_CLASS_TAG_END'
    @SET_CLASS_TAG = '#define AUTO_CLASS_TAG_BEGIN
#define AUTO_CLASS_TAG_END
AUTO_CLASS_TAG_BEGIN
AUTO_CLASS_TAG_END'
  end

  def reset
    newBundleFile
    newRImageFile
    newRXibFile
    newRStoryboardFile
    newRFileFile
  end

  ###########################################
  def filename_adjust(name)
    f = name
    f = f.gsub(/\s+/, '_') # \[*.?+$^[](){}|\/]
    f = f.gsub('-', '_')
    f = 'a' + f if f[0, 1] =~ /^[0-9]/
    f
  end

  def bundle(name)
    t = name.split('.')
    name = t[0]
    fph = File.dirname(__FILE__) + '/RBundle.h'
    fpm = File.dirname(__FILE__) + '/RBundle.m'
    name = filename_adjust(name)
    bundleClass = 'R' + name
    txtH = '@property (nonatomic,readonly) ' + bundleClass + ' *' + name + ";\n"
    txtM = 'static R' + name + ' *' + name + "_s;
-(" + bundleClass + '*)' + name + " {
    if (!" + name + "_s) {
        " + name + '_s = [' + bundleClass + " new];
        [" + name + '_s setBundle:[NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"' + name + "\" withExtension:@\"bundle\"]]];
    }
    return " + name + "_s;
}
"
    writeOCFile(fph, txtH, fpm, txtM, @PROPERTY_BEGIN)

    txtH = "@interface "+bundleClass+" : NSObject<RBundleResource>

-(NSBundle*)bundle;
-(void)setBundle:(NSBundle*)bundle;

-(" + bundleClass + "Storyboard*)storyboard;
-(" + bundleClass + "Image*)image;
-(" + bundleClass + "Xib*)xib;
-(" + bundleClass + "File*)file;

@end
"
    txtM = '@implementation ' + bundleClass + "

static NSBundle *_selfBundle_"+bundleClass+";
-(NSBundle*)bundle {
    if (_selfBundle_"+bundleClass+") {
        return _selfBundle_"+bundleClass+";
    } else {
        NSLog(@\"selfBundle is nil\");
        return [NSBundle mainBundle];
    }
}
-(void)setBundle:(NSBundle*)bundle {
    _selfBundle_"+bundleClass+" = bundle;
}

static " + bundleClass + "Storyboard *Rsb_"+bundleClass+";
-(" + bundleClass + "Storyboard*)storyboard {
if (!Rsb_"+bundleClass+") {
    Rsb_"+bundleClass+" = [" + bundleClass + "Storyboard new];
    Rsb_"+bundleClass+".bundle = [self selfBundle];
}
return Rsb_"+bundleClass+";
}
static " + bundleClass + "Image *Ri_"+bundleClass+";
-(" + bundleClass + "Image*)image {
if (!Ri_"+bundleClass+") {
    Ri_"+bundleClass+" = [" + bundleClass + "Image new];
    Ri_"+bundleClass+".bundle = [self selfBundle];
}
return Ri_"+bundleClass+";
}
static " + bundleClass + "Xib *Rx_"+bundleClass+";
-(" + bundleClass + "Xib*)xib {
if (!Rx_"+bundleClass+") {
    Rx_"+bundleClass+" = [" + bundleClass + "Xib new];
    Rx_"+bundleClass+".bundle = [self selfBundle];
}
return Rx_"+bundleClass+";
}
static " + bundleClass + "File *Rf_"+bundleClass+";
-(" + bundleClass + "File*)file {
if (!Rf_"+bundleClass+") {
    Rf_"+bundleClass+" = [" + bundleClass + "File new];
    Rf_"+bundleClass+".bundle = [self selfBundle];
}
return Rf_"+bundleClass+";
}
@end
"
    writeOCFile(fph, txtH, fpm, txtM, @CLASS_BEGIN)

    fph = File.dirname(__FILE__) + '/RImage.h'
    fpm = File.dirname(__FILE__) + '/RImage.m'
    txtH = '@interface ' + bundleClass + "Image : RBaseObject\n" + @SET_PROPERTY_TAG.gsub(/_TAG_/, '_' + bundleClass + '_') + "
@end
"
    txtM = '@implementation ' + bundleClass + "Image\n" + @SET_PROPERTY_TAG.gsub(/_TAG_/, '_' + bundleClass + '_') + "
@end
"
    writeOCFile(fph, txtH, fpm, txtM, @CLASS_BEGIN)

    fph = File.dirname(__FILE__) + '/RXib.h'
    fpm = File.dirname(__FILE__) + '/RXib.m'
    txtH = '@interface ' + bundleClass + "Xib : RBaseObject
" + @SET_PROPERTY_TAG.gsub(/_TAG_/, '_' + bundleClass + '_') + "
@end
"
    txtM = '@implementation ' + bundleClass + "Xib
" + @SET_PROPERTY_TAG.gsub(/_TAG_/, '_' + bundleClass + '_') + "
@end
"
    writeOCFile(fph, txtH, fpm, txtM, @CLASS_BEGIN)

    fph = File.dirname(__FILE__) + '/RStoryboard.h'
    fpm = File.dirname(__FILE__) + '/RStoryboard.m'
    txtH = '@interface ' + bundleClass + "Storyboard : RBaseObject
" + @SET_PROPERTY_TAG.gsub(/_TAG_/, '_' + bundleClass + '_') + "
@end
"
    txtM = '@implementation ' + bundleClass + "Storyboard
" + @SET_PROPERTY_TAG.gsub(/_TAG_/, '_' + bundleClass + '_') + "
@end
"
    writeOCFile(fph, txtH, fpm, txtM, @CLASS_BEGIN)

    fph = File.dirname(__FILE__) + '/RFile.h'
    fpm = File.dirname(__FILE__) + '/RFile.m'
    txtH = '@interface ' + bundleClass + "File : RBaseObject
" + @SET_PROPERTY_TAG.gsub(/_TAG_/, '_' + bundleClass + '_') + "
@end
"
    txtM = '@implementation ' + bundleClass + "File
" + @SET_PROPERTY_TAG.gsub(/_TAG_/, '_' + bundleClass + '_') + "
@end
"
    writeOCFile(fph, txtH, fpm, txtM, @CLASS_BEGIN)
    end

  def img(bundleClass, name)
    t = name.split('.')
    name = t[0]
    suffix = t[1]
    fph = File.dirname(__FILE__) + '/RImage.h'
    fpm = File.dirname(__FILE__) + '/RImage.m'
    # bundleClass = "R"+bundle;
    txtH = '@property (nonatomic,readonly) UIImage *' + filename_adjust(name) + ";\n"
    txtM = '-(UIImage*)' + filename_adjust(name) + ' { return [self img:@"' + name + '" suffix:@"' + suffix + "\" bundle:self.bundle]; }\n"

    imgExisted = propertyExisted(fph, txtH)
    macro_tag = @PROPERTY_BEGIN;
    if !bundleClass.nil? then
      macro_tag = macro_tag.gsub(/_TAG_/, '_R' + filename_adjust(bundleClass) + '_')
    end
    writeOCFile(fph, txtH, fpm, txtM, macro_tag) unless imgExisted
  end

  def xib(bundleClass, name)
    t = name.split('.')
    name = t[0]
    fph = File.dirname(__FILE__) + '/RXib.h'
    fpm = File.dirname(__FILE__) + '/RXib.m'
    txtH = '@property (nonatomic,readonly) UIView *' + filename_adjust(name) + ";\n"
    txtM = '-(UIView*)' + filename_adjust(name) + ' { return [[self.bundle loadNibNamed:@"' + name + "\" owner:nil options:nil] firstObject]; }\n"

    macro_tag = @PROPERTY_BEGIN;
    if !bundleClass.nil? then
      macro_tag = macro_tag.gsub(/_TAG_/, '_R' + bundleClass + '_')
    end
    writeOCFile(fph, txtH, fpm, txtM, macro_tag)
  end

  def file(bundleClass, name)
    t = name.split('.')
    name = t[0]
    suffix = t[1]
    return if suffix.nil?
    fph = File.dirname(__FILE__) + '/RFile.h'
    fpm = File.dirname(__FILE__) + '/RFile.m'
    txtH = '@property (nonatomic,readonly) NSString *' + filename_adjust(name) + ";
@property (nonatomic,readonly) NSString *" + filename_adjust(name) + "_path;\n"
    txtM = '-(NSString*)' + filename_adjust(name) + ' { return @"' + name + "\"; }
-(NSString*)" + filename_adjust(name) + '_path { return [self.bundle pathForResource:@"' + name + '" ofType:@"' + suffix + "\"]; }\n"

    macro_tag = @PROPERTY_BEGIN;
    if !bundleClass.nil? then
        macro_tag = macro_tag.gsub(/_TAG_/, '_R' + bundleClass + '_')
    end
    writeOCFile(fph, txtH, fpm, txtM, macro_tag)
  end

  def storyboard(bundleClass, name)
    t = name.split('.')
    name = t[0]
    fph = File.dirname(__FILE__) + '/RStoryboard.h'
    fpm = File.dirname(__FILE__) + '/RStoryboard.m'
    txtH = '@property (nonatomic,readonly) UIStoryboard *' + filename_adjust(name) + ";\n"
    txtM = '-(UIStoryboard*)' + name + ' { return [UIStoryboard storyboardWithName:@"' + name + "\" bundle:self.bundle]; }\n"

    macro_tag = @PROPERTY_BEGIN;
    if !bundleClass.nil? then
        macro_tag = macro_tag.gsub(/_TAG_/, '_R' + bundleClass + '_')
    end
    writeOCFile(fph, txtH, fpm, txtM, macro_tag)
  end

  def propertyExisted(f1, txt1)
    # .h
    File.open(f1, 'r') do |file|
      while line = file.gets
        return true if line.delete(' ') == txt1.delete(' ')
      end
    end
    false
  end

  def writeOCFile(f1, txt1, f2, txt2, tag)
    breakTag = "
 		"
    breakTag = ''
    # .h
    @htxt = []
    @writeed = false
    @i = 0
    File.open(f1, 'r') do |file|
      while line = file.gets
        @htxt[@i] = line
        @i += 1
        next unless line.chop.delete(' ') == tag
        next if @writeed
        @htxt[@i] = txt1
        @i += 1
        @writeed = true
       end
    end
    File.open(f1, 'w+').syswrite(@htxt.join(breakTag))

    # .m
    @mtxt = []
    @i = 0
    @writeed = false
    File.open(f2, 'r') do |file|
      while line = file.gets
        @mtxt[@i] = line
        @i += 1
        next unless line.chop.delete(' ') == tag
        next if @writeed
        @mtxt[@i] = txt2
        @i += 1
        @writeed = true
       end
    end
    File.open(f2, 'w+').syswrite(@mtxt.join(breakTag))
  end

  def newBundleFile
    fph = File.dirname(__FILE__) + '/RBundle.h'
    fpm = File.dirname(__FILE__) + '/RBundle.m'
    txtH = "#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import \"RBundleResource.h\"
#import \"RXib.h\"
#import \"RFile.h\"
#import \"RImage.h\"
#import \"RStoryboard.h\"

" + @SET_CLASS_TAG + "

@interface RBundle : NSObject
" + @SET_PROPERTY_TAG + "
@end
"
    txtM = "#import \"RBundle.h\"

" + @SET_CLASS_TAG + "

@implementation RBundle
" + @SET_PROPERTY_TAG + "
@end

"
    File.open(fph, 'w+').syswrite(txtH)
    File.open(fpm, 'w+').syswrite(txtM)
  end

  def newRImageFile
    fph = File.dirname(__FILE__) + '/RImage.h'
    fpm = File.dirname(__FILE__) + '/RImage.m'
    txtH = "#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import \"RBaseObject.h\"

@interface RImage : RBaseObject
" + @SET_PROPERTY_TAG + "
@end

" + @SET_CLASS_TAG + "

"
    txtM = "#import \"RImage.h\"
#import \"RBaseObject+MemoryCache.h\"

@implementation RImage
" + @SET_PROPERTY_TAG + "
@end

" + @SET_CLASS_TAG + "

"
    File.open(fph, 'w+').syswrite(txtH)
    File.open(fpm, 'w+').syswrite(txtM)
  end

  def newRXibFile
    fph = File.dirname(__FILE__) + '/RXib.h'
    fpm = File.dirname(__FILE__) + '/RXib.m'
    txtH = "#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import \"RBaseObject.h\"

@interface RXib : RBaseObject
" + @SET_PROPERTY_TAG + "
@end

" + @SET_CLASS_TAG + "

"
    txtM = "#import \"RXib.h\"

@implementation RXib
" + @SET_PROPERTY_TAG + "
@end

" + @SET_CLASS_TAG + "

"
    File.open(fph, 'w+').syswrite(txtH)
    File.open(fpm, 'w+').syswrite(txtM)
  end

  def newRFileFile
    fph = File.dirname(__FILE__) + '/RFile.h'
    fpm = File.dirname(__FILE__) + '/RFile.m'
    txtH = "#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import \"RBaseObject.h\"

@interface RFile : RBaseObject
" + @SET_PROPERTY_TAG + "
@end

" + @SET_CLASS_TAG + "

"
    txtM = "#import \"RXib.h\"

 @implementation RFile
 " + @SET_PROPERTY_TAG + "
 @end

 " + @SET_CLASS_TAG + "

 "
    File.open(fph, 'w+').syswrite(txtH)
    File.open(fpm, 'w+').syswrite(txtM)
  end

  def newRStoryboardFile
    fph = File.dirname(__FILE__) + '/RStoryboard.h'
    fpm = File.dirname(__FILE__) + '/RStoryboard.m'
    txtH = "#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import \"RBaseObject.h\"

@interface RStoryboard : RBaseObject
" + @SET_PROPERTY_TAG + "
@end

" + @SET_CLASS_TAG + "

"
    txtM = "#import \"RStoryboard.h\"

@implementation RStoryboard
" + @SET_PROPERTY_TAG + "
@end

" + @SET_CLASS_TAG + "

"
    File.open(fph, 'w+').syswrite(txtH)
    File.open(fpm, 'w+').syswrite(txtM)
  end
  ###########################################
end
