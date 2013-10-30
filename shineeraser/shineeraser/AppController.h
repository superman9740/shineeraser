//
//  AppController.h
//  shineeraser
//
//  Created by sdickson on 10/28/13.
//  Copyright (c) 2013 Shane Dickson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppController : NSObject
{
    
    
}
+ (id)sharedInstance;


@property (nonatomic, strong) UIImageView* mainImage;
@property (assign) BOOL  didSelectImage;
@property (assign) double  circleSize;


@end
