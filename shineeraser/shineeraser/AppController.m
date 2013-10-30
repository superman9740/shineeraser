//
//  AppController.m
//  shineeraser
//
//  Created by sdickson on 10/28/13.
//  Copyright (c) 2013 Shane Dickson. All rights reserved.
//

#import "AppController.h"
static  AppController* sharedInstance = nil;

@implementation AppController

+ (AppController *)sharedInstance {
    if (sharedInstance == nil)
    {
            sharedInstance = [[super allocWithZone:NULL] init];
        
        
    }
    
    return sharedInstance;
}



- (id)init
{
    self = [super init];
    
    if (self) {
    
        _mainImage = [[UIImageView alloc] init];
        _circleSize = 4.0;
        
        
    }
    
    return self;
}


@end
