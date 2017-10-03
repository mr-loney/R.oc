//
//  R.h
//  R-OC
//
//  Created by jun peng on 2017/7/1.
//  Copyright © 2017年 R-OC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RXib.h"
#import "RFile.h"
#import "RImage.h"
#import "RStoryboard.h"

@interface R : NSObject

+(RStoryboard*)storyboard;
+(RImage*)image;
+(RXib*)xib;
+(RFile*)file;

@end
