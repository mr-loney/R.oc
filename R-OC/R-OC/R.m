//
//  R.m
//  R-OC
//
//  Created by jun peng on 2017/7/1.
//  Copyright © 2017年 R-OC. All rights reserved.
//

#import "R.h"

@implementation R

+(RStoryboard*)storyboard {
    return [RStoryboard new];
}
+(RImage*)image {
    return [RImage new];
}
+(RXib*)xib {
    return [RXib new];
}
@end
