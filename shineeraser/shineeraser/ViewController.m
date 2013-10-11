//
//  ViewController.m
//  shineeraser
//
//  Created by Shane Dickson on 9/5/13.
//  Copyright (c) 2013 Shane Dickson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
}

-(void)viewDidAppear:(BOOL)animated
{

    UITapGestureRecognizer *singleFingerTap =    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleTap:)];
    
    [_imageView addGestureRecognizer:singleFingerTap];
    
    //The event handling method
    

    
}
- (UIBezierPath *)makeCircleAtLocation:(CGPoint)location radius:(CGFloat)radius
{
    
 
    location.y -= 25;
    location.x -= 15;
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:location
                    radius:radius
                startAngle:0.0
                  endAngle:M_PI * 2.0
                 clockwise:YES];
    
    return path;
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    
    if(firstEyeLocation.x == 0 && firstEyeLocation.y == 0)
    {
        firstEyeLocation = location;
        
    }
    else
    {
        
        secondEyeLocation = location;
        
    }

    
}

-(IBAction)removeShine:(id)sender
{

    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [[self makeCircleAtLocation:firstEyeLocation radius:3.0] CGPath];
    shapeLayer.strokeColor = nil;
    shapeLayer.fillColor = [[UIColor redColor] CGColor];
    shapeLayer.lineWidth = 1.0;
    
    // Add CAShapeLayer to our view
    
    [_imageView.layer addSublayer:shapeLayer];

    
    
    
    
    
    
}

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    _imageView.image = image;
    
    _didSelectImage = YES;

}




-(IBAction)selectPhotos:(id)sender
{
    

    if(_didSelectImage)
    {
        return;
        
    }
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker =   [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =        UIImagePickerControllerSourceTypePhotoLibrary;
        
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
        
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
