//
//  RBundleResource.h
//  ROC
//
//  Created by peng jun on 2017/11/13.
//  Copyright © 2017年 R-OC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBaseObject.h"

@protocol RBundleResource <NSObject>

@required
-(NSBundle*)selfBundle;

@optional
-(__kindof RBaseObject*)storyboard;
-(__kindof RBaseObject*)image;
-(__kindof RBaseObject*)xib;
-(__kindof RBaseObject*)file;


@end
