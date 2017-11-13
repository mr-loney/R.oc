//
//  RBaseObject.m
//  ROC
//
//  Created by peng jun on 2017/11/13.
//  Copyright © 2017年 R-OC. All rights reserved.
//

#import "RBaseObject.h"

@implementation RBaseObject

-(NSBundle*)bundle {
    return _bundle?:[NSBundle mainBundle];
}

@end
