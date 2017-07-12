//
//  RImage+MemoryCache.h
//  R-OC
//
//  Created by jun peng on 2017/7/5.
//  Copyright © 2017年 R-OC. All rights reserved.
//

#import "RImage.h"

@interface RImage (MemoryCache)

-(UIImage*)img:(NSString*)resName suffix:(NSString*)suffix bundle:(NSBundle*)bundle;

@end
