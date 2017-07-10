#import "RXib.h"

@implementation RXib
#define AUTO_PROPOTY_TAG_BEGIN
#define AUTO_PROPOTY_TAG_END
AUTO_PROPOTY_TAG_BEGIN
-(UIView*)xxx { return [[[NSBundle mainBundle] loadNibNamed:@"xxx" owner:nil options:nil] firstObject]; }AUTO_PROPOTY_TAG_END
@end