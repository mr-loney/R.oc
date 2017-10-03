//
//  R.m
//  R-OC
//
//  Created by jun peng on 2017/7/1.
//  Copyright © 2017年 R-OC. All rights reserved.
//

#import "R.h"

static RStoryboard *Rsb;
static RImage *Ri;
static RXib *Rx;
static RFile *Rf;

@implementation R

+(RStoryboard*)storyboard {
    if (!Rsb) {
        Rsb = [RStoryboard new];
    }
    return Rsb;
}
+(RImage*)image {
    if (!Ri) {
        Ri = [RImage new];
    }
    return Ri;
}
+(RXib*)xib {
    if (!Rx) {
        Rx = [RXib new];
    }
    return Rx;
}
+(RFile*)file {
    if (!Rf) {
        Rf = [RFile new];
    }
    return Rf;
}

@end
