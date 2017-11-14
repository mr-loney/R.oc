//
//  RBaseObject+MemoryCache.h
//  R-OC
//
//  Created by jun peng on 2017/11/14.
//  Copyright © 2017年 R-OC. All rights reserved.
//

#import "RBaseObject.h"
#import <UIKit/UIKit.h>

@interface RBaseObject (MemoryCache)

-(UIImage*)img:(NSString*)resName suffix:(NSString*)suffix bundle:(NSBundle*)bundle;

@end
