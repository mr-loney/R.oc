//
//  RBundleResource.m
//  ROC
//
//  Created by peng jun on 2017/11/13.
//  Copyright © 2017年 R-OC. All rights reserved.
//

#import "RBundleResource.h"

static RStoryboard *Rsb;
static RImage *Ri;
static RXib *Rx;
static RFile *Rf;

@implementation RBundleResource

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
