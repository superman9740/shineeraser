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
    
  //  UITapGestureRecognizer *twoFingerTap =    [[UITapGestureRecognizer alloc] initWithTarget:self
  //                                                                                       action:@selector(handlePinchToZoom:)];
  //  twoFingerTap.numberOfTapsRequired = 2;
    
   // [_imageView addGestureRecognizer:twoFingerTap];
    
    
   
       //note set the imageView's frame in ViewwillAppear or ViewDidAppear.
    //_imageView.frame = CGRectMake(0,0, 320, 480);


    
}
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


-(IBAction)reset:(id)sender
{
    
    NSArray* sublayers = [_imageView.layer.sublayers mutableCopy];
    
    for (CAShapeLayer* layer in sublayers )
    {
        [layer removeFromSuperlayer];
        
    }
    
}


- (void)scrollViewDidZoom:(UIScrollView *)sv
{
    UIView* zoomView = [sv.delegate viewForZoomingInScrollView:sv];
    CGRect zvf = zoomView.frame;
    if(zvf.size.width < sv.bounds.size.width)
    {
        zvf.origin.x = (sv.bounds.size.width - zvf.size.width) / 2.0;
    }
    else
    {
        zvf.origin.x = 0.0;
    }
    if(zvf.size.height < sv.bounds.size.height)
    {
        zvf.origin.y = (sv.bounds.size.height - zvf.size.height) / 2.0;
    }
    else
    {
        zvf.origin.y = 0.0;
    }
    zoomView.frame = zvf;
}

-(IBAction)handlePinchToZoom:(id)sender
{
    
//    [scrollView zoomToRect:zoomRect animated:YES];

    
}

- (UIBezierPath *)makeCircleAtLocation:(CGPoint)location radius:(CGFloat)radius
{
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:location
                    radius:radius
                startAngle:0.0
                  endAngle:M_PI * 2.0
                 clockwise:YES];
    location.x += 3;
    
    return path;
}

- (UIBezierPath *)makePointAtLocation:(CGPoint)location radius:(CGFloat)radius
{
    
    location.x += 2;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:location
                    radius:.3
                startAngle:0.0
                  endAngle:M_PI * 2.0
                 clockwise:YES];
    location.x += 3;
    
    return path;
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:recognizer.view];
    
    
    firstEyeLocation = location;
    
    
}

-(IBAction)removeShine:(id)sender
{

    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [[self makeCircleAtLocation:firstEyeLocation radius:4.0] CGPath];
    shapeLayer.strokeColor = nil;
    shapeLayer.fillColor = [[UIColor blackColor] CGColor];
    shapeLayer.lineWidth = 1.0;
    
    
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.path = [[self makePointAtLocation:firstEyeLocation radius:5.0] CGPath];
    shapeLayer2.strokeColor = nil;
    shapeLayer2.fillColor = [[UIColor whiteColor] CGColor];
    shapeLayer2.lineWidth = 1.0;
    
    // Add CAShapeLayer to our view
    
    [_imageView.layer addSublayer:shapeLayer];
    [_imageView.layer addSublayer:shapeLayer2];

    
    
    
    
    
    
}

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    _imageView.image = image;
    
    _didSelectImage = YES;

    float minimumScale = [_scrollView frame].size.width / [_imageView frame].size.width;
    _scrollView.maximumZoomScale = 100.0;
    _scrollView.minimumZoomScale = 1.0;
    _scrollView.contentSize = _imageView.image.size;
    self.scrollView.contentOffset = CGPointMake(2000, 2000);
    
    
    self.scrollView.delegate = self;
    

}




-(IBAction)selectPhotos:(id)sender
{
    

    
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
