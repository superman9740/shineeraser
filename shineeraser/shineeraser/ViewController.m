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

    UITapGestureRecognizer *singleFingerTap =    [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                         action:@selector(handleTap:)];
    
    [_imageView addGestureRecognizer:singleFingerTap];

}

-(void)viewDidAppear:(BOOL)animated
{

    
  //  UITapGestureRecognizer *twoFingerTap =    [[UITapGestureRecognizer alloc] initWithTarget:self
  //                                                                                       action:@selector(handlePinchToZoom:)];
  //  twoFingerTap.numberOfTapsRequired = 2;
    
   // [_imageView addGestureRecognizer:twoFingerTap];
    
    
   
       //note set the imageView's frame in ViewwillAppear or ViewDidAppear.
    //_imageView.frame = CGRectMake(0,0, 320, 480);
    [self reset:self];
    
    BOOL didSelectPicture = [[AppController sharedInstance] didSelectImage];
    if(didSelectPicture)
    {
        self.imageView.image = [[[AppController sharedInstance] mainImage] image];
        
        
    }
    
}
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


-(IBAction)reset:(id)sender
{
    
    NSArray* sublayers = [_imageView.layer.sublayers copy];
    
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
    
    //location.x -= 6;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:location
                    radius:radius
                startAngle:0.0
                  endAngle:M_PI * 2.0
                 clockwise:YES];
    
    return path;
}

- (UIBezierPath *)makePointAtLocation:(CGPoint)location radius:(CGFloat)radius
{
    
    //location.x -= 6;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:location
                    radius:radius
                startAngle:0.0
                  endAngle:M_PI * 2.0
                 clockwise:YES];
    
    return path;
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:recognizer.view];
    
    
    firstEyeLocation = location;
    
    
}

-(IBAction)removeShine:(id)sender
{
    double circleSize = [[AppController sharedInstance] circleSize];
    
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.path = [[self makeCircleAtLocation:firstEyeLocation radius:circleSize] CGPath];
    shapeLayer.strokeColor = nil;
    shapeLayer.fillColor = [[UIColor colorWithRed:92/255.0 green:64/255.0 blue:51/255.0 alpha:1] CGColor];
    shapeLayer.lineWidth = 1.0;
    
    CAShapeLayer* shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.path = [[self makeCircleAtLocation:firstEyeLocation radius:circleSize - .3] CGPath];
    shapeLayer2.strokeColor = nil;
    shapeLayer2.fillColor = [[UIColor blackColor] CGColor];
    shapeLayer2.lineWidth = 1.0;
    
    
    CAShapeLayer *shapeLayer3 = [CAShapeLayer layer];
    shapeLayer3.path = [[self makePointAtLocation:firstEyeLocation radius:.4] CGPath];
    shapeLayer3.strokeColor = nil;
    shapeLayer3.fillColor = [[UIColor whiteColor] CGColor];
    shapeLayer3.lineWidth = 1.0;
   
    // Add CAShapeLayer to our view
    
    [_imageView.layer addSublayer:shapeLayer];
    [_imageView.layer addSublayer:shapeLayer2];
    [_imageView.layer addSublayer:shapeLayer3];

    
    
    
    
    
    
}

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    
    _imageView.image = image;
    
    AppController* appController = [AppController sharedInstance];
    appController.didSelectImage = YES;
    
    [[[AppController sharedInstance] mainImage] setImage:_imageView.image];

    
  //  float minimumScale = [_scrollView frame].size.width / [_imageView frame].size.width;
  //  _scrollView.maximumZoomScale = 100.0;
  //  _scrollView.minimumZoomScale = 1.0;
  //  _scrollView.contentSize = _imageView.image.size;
  //  self.llView.contentOffset = CGPointMake(2000, 2000);
    
    
   // self.scrollView.delegate = self;
    
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    
    
}

-(IBAction)savePhoto:(id)sender
{
 
    UIGraphicsBeginImageContext(_imageView.frame.size);
    [self.imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* tempImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    

     UIImageWriteToSavedPhotosAlbum(tempImage, nil, nil, nil);
    UIAlertView* view = [[UIAlertView alloc] initWithTitle:@"Save photo" message:@"Photo was saved to your camera roll." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [view show];
    
    
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
