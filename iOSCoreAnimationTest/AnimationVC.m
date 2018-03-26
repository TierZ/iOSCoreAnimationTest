//
//  AnimationVC.m
//  iOSCoreAnimationTest
//
//  Created by 左晓东 on 2018/3/15.
//  Copyright © 2018年 ZXD. All rights reserved.
//

#import "AnimationVC.h"

@interface AnimationVC ()
@property (nonatomic,strong)UIView * ballView;
@end

@implementation AnimationVC{
    CALayer * squareLayer;
    CALayer * snowLayer;
    CALayer * doorLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeViewColorView];
    [self keyFrameAni];
    [self snowLayer];
    [self doorLayer];
    [self ball];
    
    
    
    // Do any additional setup after loading the view.
}
-(void)changeViewColorView{
    squareLayer = [CALayer new];
    squareLayer.backgroundColor = [UIColor redColor].CGColor;
    squareLayer.frame = CGRectMake(50, 50, 50, 50);
    [self.bgScroll.layer addSublayer:squareLayer];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"改变颜色" forState:UIControlStateNormal];
    btn.frame = CGRectMake(120, 50, 80, 30);
    [btn addTarget:self action:@selector(changeViewColor) forControlEvents:UIControlEventTouchUpInside];
    [self.bgScroll addSubview:btn];
    
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"改变颜色2" forState:UIControlStateNormal];
    btn2.frame = CGRectMake(200, 50, 100, 30);
    [btn2 addTarget:self action:@selector(changeViewColor2) forControlEvents:UIControlEventTouchUpInside];
    [self.bgScroll addSubview:btn2];
    CATransition * transiton = [CATransition animation];
    transiton.type = kCATransitionPush;
    transiton.subtype = kCATransitionFromLeft;
    squareLayer.actions = @{@"backgroundColor": transiton};
}

-(void)keyFrameAni{
    CAKeyframeAnimation * keyFrameAni = [CAKeyframeAnimation animationWithKeyPath:@"backgroundColor"];
    keyFrameAni.values = @[
                           (__bridge id)[UIColor blueColor].CGColor,
                           (__bridge id)[UIColor redColor].CGColor,
                           (__bridge id)[UIColor greenColor].CGColor,
                           (__bridge id)[UIColor blueColor].CGColor ];
    CAMediaTimingFunction * fun = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    keyFrameAni.timingFunctions = @[fun,fun,fun];
//    keyFrameAni.duration = 5.0;
    
//    [squareLayer addAnimation:keyFrameAni forKey:@"keyAniBgColor"];
    
    CAKeyframeAnimation * keyFrameAni2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];

    UIBezierPath * bezi = [UIBezierPath bezierPath];
    [bezi moveToPoint:CGPointMake(50, 50)];
    [bezi addCurveToPoint:CGPointMake(250, 200) controlPoint1:CGPointMake(100,100) controlPoint2:CGPointMake(180, 60)];
    keyFrameAni2.path = bezi.CGPath;
//    keyFrameAni2.duration = 5;
//    keyFrameAni2.rotationMode = kCAAnimationRotateAuto;
//    [squareLayer addAnimation:keyFrameAni2 forKey:@"keyAniPosition"];
    
    CABasicAnimation * rotationAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//    rotationAni.duration = 5;
    rotationAni.toValue = @(M_PI_4);
//    [squareLayer addAnimation:rotationAni forKey:@"keyAnirotation"];
    
    CAAnimationGroup * groupAni = [CAAnimationGroup animation];
    groupAni.animations = @[keyFrameAni,keyFrameAni2,rotationAni];
    groupAni.duration = 15;
    groupAni.fillMode = kCAFillModeForwards;
    groupAni.removedOnCompletion = NO;
    [squareLayer addAnimation:groupAni forKey:@"groupAni"];
}

-(void)snowLayer{
    snowLayer = [CALayer layer];
    snowLayer.frame = CGRectMake(30, 80, 50, 50);
    snowLayer.contents = (__bridge id)[UIImage imageNamed:@"DazFlakeIcon"].CGImage;
    [self.bgScroll.layer addSublayer:snowLayer];
    
    UIButton * startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startBtn setTitle:@"开始动画" forState:UIControlStateNormal];
    startBtn.frame = CGRectMake(30, 150, 80, 30);
    [startBtn addTarget:self action:@selector(startAni) forControlEvents:UIControlEventTouchUpInside];
    [self.bgScroll addSubview:startBtn];
    
    UIButton * stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [stopBtn setTitle:@"结束动画" forState:UIControlStateNormal];
    stopBtn.frame = CGRectMake(120, 150, 80, 30);
    [stopBtn addTarget:self action:@selector(stopAni) forControlEvents:UIControlEventTouchUpInside];
    [self.bgScroll addSubview:stopBtn];
}

-(void)doorLayer{
    doorLayer = [CALayer layer];
    doorLayer.contents = (__bridge id)[UIImage imageNamed:@"光荣大地"].CGImage;
    doorLayer.frame = CGRectMake(200, 80, 80, 120);
    doorLayer.anchorPoint = CGPointMake(0, 0.5);
    [self.bgScroll.layer addSublayer:doorLayer];
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1/500.0;
    doorLayer.transform = transform;
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.toValue = @(-M_PI_2);
    animation.duration = 2.0;
    animation.repeatDuration = INFINITY;
    animation.autoreverses = YES;
    [doorLayer addAnimation:animation forKey:nil];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panDoor:)];
    [self.bgScroll addGestureRecognizer:pan];
    doorLayer.speed = 0.0;
    
}

-(void)ball{
    self.ballView = [[UIView alloc] initWithFrame:CGRectMake(130, 250, 40, 40)];
    self.ballView.layer.masksToBounds = YES;
    self.ballView.layer.cornerRadius  = 20;
    self.ballView.backgroundColor = [UIColor greenColor];
    [self.bgScroll addSubview:self.ballView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self ballAnimate];
    });
}

- (void)ballAnimate {
    //reset ball to top of screen
    self.ballView.center = CGPointMake(150, 270);
    //create keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation]; animation.keyPath = @"position";
    animation.duration = 1.0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
//    animation.delegate = self;
    animation.values = @[
                         [NSValue valueWithCGPoint:CGPointMake(150, 270)], [NSValue valueWithCGPoint:CGPointMake(150, 470)], [NSValue valueWithCGPoint:CGPointMake(150, 370)], [NSValue valueWithCGPoint:CGPointMake(150, 470)], [NSValue valueWithCGPoint:CGPointMake(150, 420)], [NSValue valueWithCGPoint:CGPointMake(150, 470)], [NSValue valueWithCGPoint:CGPointMake(150, 445)], [NSValue valueWithCGPoint:CGPointMake(150, 470)] ];
    animation.timingFunctions = @[
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn], [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut], [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn], [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut], [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn], [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut], [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn]
                                  ];
    animation.keyTimes = @[@0.0, @0.3, @0.5, @0.7, @0.8, @0.9, @0.95, @1.0]; //apply animation
    [self.ballView.layer addAnimation:animation forKey:nil];
}


-(void)panDoor:(UIPanGestureRecognizer*)pan{
    //get horizontal component of pan gesture
    CGFloat x = [pan translationInView:self.bgScroll].x;
    NSLog(@"x = %f",x);
    //convert from points to animation duration //using a reasonable scale factor
    x /= 150.0f;
    //update timeOffset and clamp result
    CFTimeInterval timeOffset = doorLayer .timeOffset;
    NSLog(@"timeOffset = %f",timeOffset);
//    timeOffset = MIN(0.999, MAX(0.0, timeOffset - x));
    timeOffset = timeOffset-x;
    doorLayer.timeOffset = timeOffset;
    //reset pan gesture
    [pan setTranslation:CGPointZero inView:self.bgScroll];
}
#pragma mark action

-(void)startAni{
    CABasicAnimation * startAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    startAni.toValue = @(M_PI/3.0);
    startAni.duration = 5;
    startAni.fillMode = kCAFillModeForwards;
    startAni.removedOnCompletion = NO;
    [snowLayer addAnimation:startAni forKey:@"snowRotationAni"];
}
-(void)stopAni{
    [snowLayer removeAllAnimations];
}
-(void)changeViewColor{
    [CATransaction begin];
    [CATransaction setAnimationDuration:1];
    squareLayer.backgroundColor = RandomColor(1).CGColor;
    [CATransaction setCompletionBlock:^{
        CGAffineTransform  affine = squareLayer.affineTransform;
        affine = CGAffineTransformRotate(affine, M_PI_4);
        squareLayer.affineTransform = affine;
    }];
    [CATransaction commit];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject]locationInView:self.bgScroll];
    if ([squareLayer.presentationLayer hitTest:point]) {
        NSLog(@"点击到layer");
        [self changeViewColor2];
    }else{
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.5];
        squareLayer.position = point;
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];

        [CATransaction commit];
    }
    
}

-(void)changeViewColor2{
    squareLayer.backgroundColor = RandomColor(1).CGColor;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
