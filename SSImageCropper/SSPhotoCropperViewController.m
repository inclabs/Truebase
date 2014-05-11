
/*
 Copyright 2011 Ahmet Ardal
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

//
//  SSPhotoCropperViewController.m
//  SSPhotoCropperDemo
//
//  Created by Ahmet Ardal on 10/17/11.
//  Copyright 2011 SpinningSphere Labs. All rights reserved.
//

#import "SSPhotoCropperViewController.h"

@interface SSPhotoCropperViewController(Private)
- (void) loadPhoto;
- (void) setScrollViewBackground;
- (IBAction) saveAndClose:(id)sender;
- (IBAction) cancelAndClose:(id)sender;
- (BOOL) isRectanglePositionValid:(CGPoint)pos;
- (IBAction) imageMoved:(id)sender withEvent:(UIEvent *)event;
- (IBAction) imageTouch:(id)sender withEvent:(UIEvent *)event;
@end

@implementation SSPhotoCropperViewController

@synthesize scrollView, photo, imageView, cropRectangleButton, infoButton, cDelegate,
            minZoomScale, maxZoomScale, infoMessageTitle, infoMessageBody, photoCropperTitle;

- (id) initWithPhoto:(UIImage *)aPhoto
            delegate:(id<SSPhotoCropperDelegate>)aDelegate
{
    return [self initWithPhoto:aPhoto
                      delegate:aDelegate
                        uiMode:SSPCUIModePresentedAsModalViewController
               showsInfoButton:YES];
}

- (id) initWithPhoto:(UIImage *)aPhoto
            delegate:(id<SSPhotoCropperDelegate>)aDelegate
              uiMode:(SSPhotoCropperUIMode)uiMode
     showsInfoButton:(BOOL)showsInfoButton
{
    if (!(self = [super initWithNibName:@"SSPhotoCropperViewController" bundle:nil])) {
        return self;
    }

    self.photo = aPhoto;
    self.cDelegate = aDelegate;
    _uiMode = uiMode;
    _showsInfoButton = showsInfoButton;

    self.minZoomScale = 0.5f;
    self.maxZoomScale = 3.0f;

    self.infoMessageTitle = @"Crop Photo";
    self.infoMessageBody = @"Use two of your fingers to zoom in and out the photo and drag the"
                           @" green window to crop any part of the photo you would like to use. Resize crop box using yellow point in the down right corner.";
    self.photoCropperTitle = @"Crop Photo";

    return self;
}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.photo = nil;
        self.cDelegate = nil;
    }
    return self;
}

/*- (void) dealloc
{
    [self.scrollView release];
    [self.photo release];
    [self.imageView release];
    [self.cropRectangleButton release];
    [self.infoButton release];
    [self.infoMessageTitle release];
    [self.infoMessageBody release];
    [self.photoCropperTitle release];
    [super dealloc];
}*/

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction) infoButtonTapped:(id)sender
{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:self.infoMessageTitle
                                                 message:self.infoMessageBody
                                                delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
    [av show];
    //[av release];
}


#pragma -
#pragma mark - View lifecycle

- (void) viewDidLoad
{
    [super viewDidLoad];

    //
    // setup view ui
    //
    UIBarButtonItem *bi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                        target:self
                                                                        action:@selector(saveAndClose:)];
    self.navigationItem.rightBarButtonItem = bi;
    //[bi release];

    if (_uiMode == SSPCUIModePresentedAsModalViewController) {
        bi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                           target:self
                                                           action:@selector(cancelAndClose:)];
        self.navigationItem.leftBarButtonItem = bi;
        //[bi release];
    }

    if (!_showsInfoButton) {
        [self.infoButton setHidden:YES];
    }

    self.title = self.photoCropperTitle;

    //
    // photo cropper ui stuff
    //
    [self setScrollViewBackground];
    [self.scrollView setMinimumZoomScale:self.minZoomScale];
    [self.scrollView setMaximumZoomScale:self.maxZoomScale];

    [self.cropRectangleButton addTarget:self
                                 action:@selector(imageTouch:withEvent:)
                       forControlEvents:UIControlEventTouchDown];
    [self.cropRectangleButton addTarget:self
                                 action:@selector(imageMoved:withEvent:)
                       forControlEvents:UIControlEventTouchDragInside];

    if (self.photo != nil) {
        [self loadPhoto];
    }
    UIImage *img = [[UIImage imageNamed:@"photo_cropper_bg.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    [self.cropRectangleButton setBackgroundImage:img forState:(UIControlStateNormal)];
    img = [[UIImage imageNamed:@"photo_cropper_rect_on"] stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    [self.cropRectangleButton setBackgroundImage:img forState:(UIControlStateHighlighted)];
    
    CGRect r = [self.cropRectangleButton frame];
    UIButton *b = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [b setImage:[UIImage imageNamed:@"corner.png"] forState:(UIControlStateNormal)];
    [b setFrame:CGRectMake(r.size.width-30, r.size.height-30, 30, 30)];
    [self.cropRectangleButton addSubview:b];
    [b setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin)];
    [b setTag:1010];
    [b addTarget:self action:@selector(imageTouch:withEvent:) forControlEvents:UIControlEventTouchDown];
    [b addTarget:self action:@selector(imageMoved:withEvent:) forControlEvents:UIControlEventTouchDragInside];
}

- (void) viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (void)setCropSize:(CGSize)aSize
{
    CGFloat w = aSize.width;
    CGFloat h = aSize.height;
    if (w > h) {
        CGFloat ratio = w*1.0/h;
        w = h = 180;
        w = 180*ratio;
    }
    else if (w < h) {
        CGFloat ratio = h*1.0/w;
        w = h = 180;
        h = 180*ratio;
    }
    else
    {
        w = h = 180;
    }
    if (w > 280)
    {
        CGFloat ratio = 280/w;
        w = w * ratio;
        h = h * ratio;
        
        if (h > 300) {
            CGFloat ratio = 300/h;
            w = w * ratio;
            h = h * ratio;
        }
    }
    if (h > 300) {
        CGFloat ratio = 300/h;
        w = w * ratio;
        h = h * ratio;
        
        if (w > 280) {
            CGFloat ratio = 280/w;
            w = w * ratio;
            h = h * ratio;
        }
    }
   
    cropRectangleButton.frame = CGRectMake(0, 0, 120, 120);
    UIImage *img = [[UIImage imageNamed:@"photo_cropper_rect"] stretchableImageWithLeftCapWidth:25 topCapHeight:20];
    [self.cropRectangleButton setBackgroundImage:img forState:(UIControlStateNormal)];
    img = [[UIImage imageNamed:@"photo_cropper_rect_on"] stretchableImageWithLeftCapWidth:25 topCapHeight:20];
    [self.cropRectangleButton setBackgroundImage:img forState:(UIControlStateHighlighted)];
    
    
}

- (void)crop
{
    [self saveAndClose:nil];
}

- (void)updatePhoto
{
    [self loadPhoto];
}

#pragma -
#pragma UIScrollViewDelegate Methods

- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


#pragma -
#pragma Private Methods

- (void) loadPhoto
{
    if (self.photo == nil) {
        return;
    }

    CGFloat w = self.photo.size.width;
    CGFloat h = self.photo.size.height;
    CGRect imageViewFrame = CGRectMake(0.0f, 0.0f, roundf(w / 2.0f), roundf(h / 2.0f));
    self.scrollView.contentSize = imageViewFrame.size;

    UIImageView *iv = [[UIImageView alloc] initWithFrame:imageViewFrame];
   // iv.contentMode=UIViewContentModeScaleAspectFit;
    iv.image = self.photo;
    if (self.imageView) {
        [self.imageView removeFromSuperview];
        self.imageView = nil;
    }
    [self.scrollView addSubview:iv];
    self.imageView = iv;
   // [iv release];
}

- (void) setScrollViewBackground
{
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"photo_cropper_bg"]];
}

- (UIImage *) croppedPhoto
{
    CGFloat ox = self.scrollView.contentOffset.x;
    CGFloat oy = self.scrollView.contentOffset.y;
    CGFloat zoomScale = self.scrollView.zoomScale;
    CGFloat cx = (ox + self.cropRectangleButton.frame.origin.x) * 2.0f / zoomScale;
    CGFloat cy = (oy + self.cropRectangleButton.frame.origin.y) * 2.0f / zoomScale;
    CGFloat cw = (self.cropRectangleButton.frame.size.width*2) / zoomScale;
    CGFloat ch = (self.cropRectangleButton.frame.size.height*2) / zoomScale;
    CGRect cropRect = CGRectMake(cx, cy, cw, ch);
    
    NSLog(@"---------- cropRect: %@", NSStringFromCGRect(cropRect));
    NSLog(@"--- self.photo.size: %@", NSStringFromCGSize(self.photo.size));
    
    
    
    CGSize itemSize = self.photo.size;
  
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [self.photo drawInRect:imageRect];
   
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  
     
   
    UIGraphicsEndImageContext();
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([newImage CGImage], cropRect);
    
    UIImage *result1 = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    UIImage *result=[self resizedImage:result1 :CGRectMake(0.0, 0.0, itemSize.width, itemSize.height)];
    NSLog(@"------- result.size: %@", NSStringFromCGSize(result.size));
    
    return result;
}

-(UIImage*) resizedImage:(UIImage *)inImage: (CGRect) thumbRect
{
    CGImageRef          imageRef = [inImage CGImage];
    CGImageAlphaInfo    alphaInfo = CGImageGetAlphaInfo(imageRef);
    
    // There's a wierdness with kCGImageAlphaNone and CGBitmapContextCreate
    // see Supported Pixel Formats in the Quartz 2D Programming Guide
    // Creating a Bitmap Graphics Context section
    // only RGB 8 bit images with alpha of kCGImageAlphaNoneSkipFirst, kCGImageAlphaNoneSkipLast, kCGImageAlphaPremultipliedFirst,
    // and kCGImageAlphaPremultipliedLast, with a few other oddball image kinds are supported
    // The images on input here are likely to be png or jpeg files
    if (alphaInfo == kCGImageAlphaNone)
        alphaInfo = kCGImageAlphaNoneSkipLast;
    
    // Build a bitmap context that's the size of the thumbRect
    CGContextRef bitmap = CGBitmapContextCreate(
                                                NULL,
                                                thumbRect.size.width,       // width
                                                thumbRect.size.height,      // height
                                                CGImageGetBitsPerComponent(imageRef),   // really needs to always be 8
                                                4 * thumbRect.size.width,   // rowbytes
                                                CGImageGetColorSpace(imageRef),
                                                alphaInfo
                                                );
    
    // Draw into the context, this scales the image
    CGContextDrawImage(bitmap, thumbRect, imageRef);
    
    // Get an image from the context and a UIImage
    CGImageRef  ref = CGBitmapContextCreateImage(bitmap);
    UIImage*    result = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);   // ok if NULL
    CGImageRelease(ref);
    
    return result;
}

- (IBAction) saveAndClose:(id)sender
{
    NSLog(@"----------- zoomScale: %.04f", self.scrollView.zoomScale);
    NSLog(@"------- contentOffset: %@", NSStringFromCGPoint(self.scrollView.contentOffset));
    NSLog(@"-- contentScaleFactor: %.04f", self.scrollView.contentScaleFactor);
    NSLog(@"--------- contentSize: %@", NSStringFromCGSize(self.scrollView.contentSize));

    if (self.cDelegate && [self.cDelegate respondsToSelector:@selector(photoCropper:didCropPhoto:)]) {
        [self.cDelegate photoCropper:self didCropPhoto:[self croppedPhoto]];
    }
}

- (IBAction) cancelAndClose:(id)sender
{
    if (self.cDelegate && [self.cDelegate respondsToSelector:@selector(photoCropperDidCancel:)]) {
        [self.cDelegate photoCropperDidCancel:self];
    }
}

- (BOOL) isRectanglePositionValid:(CGPoint)pos
{
    CGRect innerRect = CGRectMake((pos.x), (pos.y), self.cropRectangleButton.frame.size.width, self.cropRectangleButton.frame.size.height);
    return CGRectContainsRect(self.scrollView.frame, innerRect);
}


- (IBAction) imageMoved:(id)sender withEvent:(UIEvent *)event
{
    CGPoint point = [[[event allTouches] anyObject] locationInView:self.view];
    UIControl *button = sender;
    
    
    CGPoint prev = _lastTouchDownPoint;
    _lastTouchDownPoint = point;
    
    if (button.tag == 1010)
    {
        CGRect newFrame = button.superview.frame;
        CGFloat diffX = point.x - prev.x;
        CGFloat diffY = point.y - prev.y;
        newFrame.size.width += diffX;
        newFrame.size.height += diffX;
        if (newFrame.size.width >= 25 && newFrame.size.height >= 25 && newFrame.size.width+newFrame.origin.x <= self.scrollView.frame.size.width && newFrame.size.height+newFrame.origin.y <= self.scrollView.frame.size.height)
        {
            button.superview.frame = newFrame;
        }
    }
    else
    {
        CGRect newFrame = button.frame;
        CGFloat diffX = point.x - prev.x;
        CGFloat diffY = point.y - prev.y;
        newFrame.origin.x += diffX;
        newFrame.origin.y += diffY;
        if ([self isRectanglePositionValid:newFrame.origin])
        {
            button.frame = newFrame;
        }
    }
    
}

- (IBAction) imageTouch:(id)sender withEvent:(UIEvent *)event
{
    CGPoint point = [[[event allTouches] anyObject] locationInView:self.view];
    _lastTouchDownPoint = point;
    NSLog(@"imageTouch. point: %@", NSStringFromCGPoint(point));
}

@end
