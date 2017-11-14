//
//  RBaseObject+MemoryCache.m
//  R-OC
//
//  Created by jun peng on 2017/11/14.
//  Copyright © 2017年 R-OC. All rights reserved.
//

#import "RBaseObject+MemoryCache.h"

@implementation RBaseObject (MemoryCache)

-(UIImage*)img:(NSString*)resName suffix:(NSString*)suffix bundle:(NSBundle*)bundle {
    if (!bundle) { bundle = [NSBundle mainBundle]; }
    
    NSString *p = [bundle pathForResource:resName ofType:suffix];
    if (!p) {
        p = [bundle pathForResource:resName ofType:@"tiff"];
    }
    if (p && p.length > 0) {
        UIImage *image = [UIImage imageWithContentsOfFile:p];
        if (!image) {
            return nil;
        }
        
        return image;
    }
    return nil;
}

@end
