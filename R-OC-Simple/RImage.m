#import "RImage.h"
#import "RImage+MemoryCache.h"

@implementation RImage
#define AUTO_PROPOTY_TAG_BEGIN
#define AUTO_PROPOTY_TAG_END
AUTO_PROPOTY_TAG_BEGIN
-(UIImage*)tab_me_off { return [self img:@"tab_me_off" suffix:@"png"]; }-(UIImage*)tab_me_on { return [self img:@"tab_me_on" suffix:@"png"]; }AUTO_PROPOTY_TAG_END
@end