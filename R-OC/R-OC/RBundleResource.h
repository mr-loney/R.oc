//
//  RBundleResource.h
//  ROC
//
//  Created by peng jun on 2017/11/13.
//  Copyright © 2017年 R-OC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RXib.h"
#import "RFile.h"
#import "RImage.h"
#import "RStoryboard.h"

@interface RBundleResource : NSObject

+(RStoryboard*)storyboard;
+(RImage*)image;
+(RXib*)xib;
+(RFile*)file;

@end
