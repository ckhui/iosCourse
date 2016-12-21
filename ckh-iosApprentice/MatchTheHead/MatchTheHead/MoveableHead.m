//
//  MoveableHead.m
//  MatchTheHead
//
//  Created by NEXTAcademy on 10/27/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "MoveableHead.h"

@interface  MoveableHead() <UIGestureRecognizerDelegate>

@end


@implementation MoveableHead

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        self.userInteractionEnabled = YES;
        
        UIPanGestureRecognizer *panGasture = [[ UIPanGestureRecognizer alloc ] initWithTarget:self action:@selector(handlePanGesture:)];
        
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
        
        UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(handleRotationGesture:)];
        
        self.gestureRecognizers = @[panGasture,pinchGesture,rotationGesture];
        
        for (UIGestureRecognizer *recognizer in self.gestureRecognizers){
            recognizer.delegate = self;
        }
    }
    
    return self;
}

#pragma  mark - Gesture Recognizers
- (void) handlePanGesture:(UIPanGestureRecognizer *)panGesture{
    if(panGesture.state == UIGestureRecognizerStateBegan || panGesture.state == UIGestureRecognizerStateChanged){
        
        // the change of touch in view
        CGPoint translation = [panGesture translationInView:panGesture.view];
        
        NSLog(@"View movew [%f, %f]", translation.x, translation.y);
        // move the view in accordance of the touch
        [panGesture.view setTransform:CGAffineTransformTranslate(panGesture.view.transform, translation.x, translation.y)];
        
        // set the  touch to reposition itself in view
        [panGesture setTranslation:CGPointZero inView:panGesture.view];
        
    }
    
}

- (void) handlePinchGesture:(UIPinchGestureRecognizer *)pinchGesture{
    if(pinchGesture.state == UIGestureRecognizerStateBegan || pinchGesture.state == UIGestureRecognizerStateChanged){
        
        //get the scale from the distance of 2 fingures / gesture
        CGFloat scale = [pinchGesture scale];
        
        //resize / transform the view with scale
        [pinchGesture.view setTransform:CGAffineTransformScale(pinchGesture.view.transform, scale, scale)];
        
        //reset the scale in the view which already scaled
        [pinchGesture setScale:1];
        
    }
}

- (void) handleRotationGesture:(UIRotationGestureRecognizer *)rotationGesture{
    if (rotationGesture.state == UIGestureRecognizerStateBegan || rotationGesture.state == UIGestureRecognizerStateChanged){
        
        //get rotation
        CGFloat rotation = [rotationGesture rotation];
        
        //rotate
        [rotationGesture.view setTransform:CGAffineTransformRotate(rotationGesture.view.transform, rotation)];
        
        //reset
        [rotationGesture setRotation:0];
    }
}

#pragma mark - UIGestureRecognizer Delegate

- (bool) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

@end
