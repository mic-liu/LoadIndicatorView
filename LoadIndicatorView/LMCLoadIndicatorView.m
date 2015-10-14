//
//  LMCLoadIndicatorView.m
//  LoadIndicatorView
//
//  Created by LiuMingchuan on 15/10/14.
//  Copyright © 2015年 LMC. All rights reserved.
//

#define MOVE_ROUND_ANIM_KEY @"moveRoundAnimation"

#import "LMCLoadIndicatorView.h"


@implementation LMCLoadIndicatorView {
    /**
     *  gradientLayer
     */
    CAGradientLayer *_gradientLayer;
    /**
     *  rolling animation
     */
    CABasicAnimation *_moveRoundAnimation;
}

/**
 *  Initialize the view
 *
 *  @param frame frame
 *
 *  @return Instance
 */
-(instancetype)initWithFrame:(CGRect)frame {
    //minWidth check
    if (frame.size.width<15) {
        frame.size.width = 15;
    }
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.width)]) {
        //make indicator
        [self makeIndocator];
    }
    return self;
}
/**
 *  make indicator
 */
- (void)makeIndocator{
    CGFloat radius = (self.frame.size.width-10)/2;
    CGPoint center = CGPointMake(radius, radius);
    
    //berzier path
    //【1.gif】
//    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:4*M_PI/2.2 endAngle:M_PI/3 clockwise:NO];
    //【2.gif】
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:2*M_PI endAngle:0 clockwise:NO];
    
    //gradient color array
    NSMutableArray *gradientColorArray = [NSMutableArray arrayWithObjects:(id)[UIColor redColor].CGColor, (id)[UIColor whiteColor].CGColor, nil];
    //gradient layer
    _gradientLayer = [CAGradientLayer layer];
    
    //set gradient color
    [_gradientLayer setColors:gradientColorArray];
    
    _gradientLayer.frame = self.bounds;
    
    //set self.layer‘s sublayer
    [self.layer addSublayer:_gradientLayer];
    
    CGFloat shapeLayerWidth = self.bounds.size.width-10;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.fillMode = kCAFillRuleEvenOdd;
    shapeLayer.path = circlePath.CGPath;
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer.lineWidth = shapeLayerWidth/10;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.frame = CGRectMake(5, 5, shapeLayerWidth, shapeLayerWidth);
    //【3.gif】
//    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:@10, nil]];
    
    //set gradientLayer's mask layer
    _gradientLayer.mask = shapeLayer;
    
    //create rolling animation
    _moveRoundAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    _moveRoundAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    _moveRoundAnimation.fromValue = [NSNumber numberWithFloat:0];
    _moveRoundAnimation.toValue = [NSNumber numberWithFloat:2*M_PI];
    _moveRoundAnimation.duration = 1.5;
    _moveRoundAnimation.repeatCount = HUGE_VALF;
    
    [_gradientLayer addAnimation:_moveRoundAnimation forKey:MOVE_ROUND_ANIM_KEY];
    
    //regist application’s notification
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didApplicationEnterBackGround) name:UIApplicationDidEnterBackgroundNotification object:[UIApplication sharedApplication]];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(willApplicationEdterForeground) name:UIApplicationWillEnterForegroundNotification object:[UIApplication sharedApplication]];
    
}

/**
 *  when application pauseback , remove the rolling animation
 */
- (void)didApplicationEnterBackGround {
    [_gradientLayer removeAnimationForKey:MOVE_ROUND_ANIM_KEY];}

/**
 *  when application resumed , reset the rolling animation
 */
- (void)willApplicationEdterForeground {
    [_gradientLayer addAnimation:_moveRoundAnimation forKey:MOVE_ROUND_ANIM_KEY];
}

@end
