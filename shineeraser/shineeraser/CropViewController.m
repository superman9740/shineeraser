//
//  CropViewController.m
//  shineeraser
//
//  Created by sdickson on 10/28/13.
//  Copyright (c) 2013 Shane Dickson. All rights reserved.
//

#import "CropViewController.h"


@interface CropViewController ()

@end

@implementation CropViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	

    
}
-(void)viewWillAppear:(BOOL)animated
{
    _imageView.image = [[[AppController sharedInstance] mainImage ] image];
    BOOL didSelectImage = [[AppController sharedInstance] didSelectImage];
    if(didSelectImage)
    {
   
        _imageCropperViewController = [[YKImageCropperViewController alloc] initWithImage:_imageView.image];
        _imageCropperViewController.cancelHandler = ^() {
            NSLog(@"* Cancel");
        };
        __weak CropViewController* cropSelf = self;
        
        _imageCropperViewController.doneHandler = ^(UIImage *editedImage) {
            NSLog(@"* Done");
            cropSelf.imageView.image = editedImage;
            [[[AppController sharedInstance] mainImage ] setImage:editedImage];
            
            [cropSelf.imageCropperViewController.view removeFromSuperview];
            
            
            
            
        };
        
        [_imageView addSubview:_imageCropperViewController.view];
        
        
        
    }
    
    
}

-(IBAction)save:(id)sender
{
    [_imageCropperViewController doneAction];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
