//
//  Layer3VC.m
//  iOSCoreAnimationTest
//
//  Created by 左晓东 on 2018/3/6.
//  Copyright © 2018年 ZXD. All rights reserved.
//

#import "Layer3VC.h"
#import "LayerLabel.h"
@interface Layer3VC ()

@end

@implementation Layer3VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bgScroll.contentSize = CGSizeMake(self.bgScroll.frame.size.width, 2000);

    [self setupShapeLayer];
    [self setupTextLayer];
    [self catransformLayer];
    [self caGradientLayer];
    [self caReplicatorLayer];
    [self caSnowEmmiterLayer];
    // Do any additional setup after loading the view.
}
#pragma mark cashapelayer
-(void)setupShapeLayer{
    UIBezierPath * shapeBezi = [UIBezierPath bezierPath];
    [shapeBezi moveToPoint:CGPointMake(125, 80)];
    [shapeBezi addArcWithCenter:CGPointMake(100, 80) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [shapeBezi moveToPoint:CGPointMake(100, 105)];
    [shapeBezi addLineToPoint:CGPointMake(100, 180)];
    [shapeBezi moveToPoint:CGPointMake(100, 180)];
    [shapeBezi addLineToPoint:CGPointMake(75, 200)];
    [shapeBezi moveToPoint:CGPointMake(100, 180)];
    [shapeBezi addLineToPoint:CGPointMake(125, 200)];
    [shapeBezi moveToPoint:CGPointMake(75, 120)];
    [shapeBezi addLineToPoint:CGPointMake(125, 120)];
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = 1;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineJoin= kCALineCapRound;
    shapeLayer.path = shapeBezi.CGPath;
    shapeLayer.fillColor = [UIColor redColor].CGColor;
    shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    [self.bgScroll.layer addSublayer:shapeLayer];
}

#pragma mark catextlayer
-(void)setupTextLayer{
    CATextLayer * textLayer = [CATextLayer layer];
    textLayer.frame = CGRectMake(150, 80, 100, 100);
    textLayer.wrapped = YES;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    UIFont * font = [UIFont systemFontOfSize:15];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.fontSize = font.pointSize;
    textLayer.font = fontRef;
    textLayer.foregroundColor = [UIColor redColor].CGColor;
    textLayer.backgroundColor = [UIColor greenColor].CGColor;
    textLayer.string = @"你好哈登你啥都没弄规划师的你挂开始到后期维护奥术大师感受到将更好地gas的";
    [self.bgScroll.layer addSublayer:textLayer];
    
    LayerLabel * layerLab = [[LayerLabel alloc]initWithFrame:CGRectMake(270, 80, 40, 100)];
    layerLab.numberOfLines = 0;
    layerLab.textColor = [UIColor yellowColor];
    layerLab.backgroundColor = [UIColor blueColor];
    layerLab.font = [UIFont systemFontOfSize:13];
    layerLab.text = @"三点减肥那是的光华科技环球文化阿斯顿好看讲话稿考好点你能干啥规划师的好";
//    [layerLab sizeToFit];

    [self.bgScroll addSubview:layerLab];
}

#pragma mark CAGradientLayer
-(void)caGradientLayer{
    UIView * gradientLayerV = [UIView new];
//    gradientLayerV.backgroundColor = [UIColor redColor];
    gradientLayerV.frame = CGRectMake(150, 300, 100, 100);
    [self.bgScroll addSubview:gradientLayerV];
    
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = gradientLayerV.bounds;
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                             (__bridge id)[UIColor orangeColor].CGColor,
                             (__bridge id)[UIColor yellowColor].CGColor,
                             (__bridge id)[UIColor greenColor].CGColor,
                             (__bridge id)[UIColor cyanColor].CGColor,
                             (__bridge id)[UIColor blueColor].CGColor,
                             (__bridge id)[UIColor purpleColor].CGColor,];
    [gradientLayerV.layer addSublayer:gradientLayer];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@0.0,@0.16,@0.32,@0.5,@0.66,@0.82,@0.9,@1];
}

#pragma mark CAReplicatorLayer
-(void)caReplicatorLayer{
//    UIView * replicator2View = [UIView new];
//    replicator2View.frame = CGRectMake(100, 650,100, 40);
//    [self.bgScroll addSubview:replicator2View];

    CAReplicatorLayer * repLayer2 = [CAReplicatorLayer layer];
    repLayer2.frame = CGRectMake(100, 650, 60, 100);
    repLayer2.instanceCount = 3;
    repLayer2.backgroundColor = [UIColor greenColor].CGColor;
    repLayer2.masksToBounds = YES;
   
    repLayer2.instanceTransform = CATransform3DMakeTranslation(15, 0, 0);
    repLayer2.instanceBlueOffset = -0.1;
    repLayer2.instanceGreenOffset = -0.1;
    repLayer2.instanceDelay = 0.2;

    [self.bgScroll.layer addSublayer:repLayer2];

    CALayer *tLayer = [CALayer layer];
    tLayer.frame = CGRectMake(10, 80, 10, 40);
    tLayer.backgroundColor = [UIColor redColor].CGColor;
    [repLayer2 addSublayer:tLayer];

    CABasicAnimation *musicAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    musicAnimation.duration = 0.35;
    musicAnimation.fromValue = @(80);
    musicAnimation.toValue = @(110);
    musicAnimation.autoreverses = YES;
    musicAnimation.repeatCount = MAXFLOAT;

    [tLayer addAnimation:musicAnimation forKey:@"musicAnimation"];
    
    
    
    
    
    UIBezierPath *tPath = [UIBezierPath bezierPath];
    [tPath moveToPoint:CGPointMake(kScreenWidth/2.0, 400)];
    [tPath addQuadCurveToPoint:CGPointMake(kScreenWidth/2.0, 600) controlPoint:CGPointMake(kScreenWidth/2.0 + 200, 200)];
    [tPath addQuadCurveToPoint:CGPointMake(kScreenWidth/2.0, 400) controlPoint:CGPointMake(kScreenWidth/2.0 - 200, 200)];
    [tPath closePath];
    
    UIView *replicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    replicatorView.center = CGPointMake(kScreenWidth/2.0, 200);
    replicatorView.layer.cornerRadius = 5;
    replicatorView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    
    CAKeyframeAnimation * keyFrameAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAni.duration = 8;
    keyFrameAni.path = tPath.CGPath;
    keyFrameAni.repeatCount = MAXFLOAT;
    [replicatorView.layer addAnimation:keyFrameAni forKey:@"keyFrameAni"];
    
    CAReplicatorLayer * repLayer = [CAReplicatorLayer layer];
    repLayer.instanceCount = 50;
    repLayer.instanceDelay = 0.2;
    repLayer.instanceColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor;
    repLayer.instanceGreenOffset = -0.03;       // 颜色值递减。
    repLayer.instanceRedOffset = -0.02;         // 颜色值递减。
    repLayer.instanceBlueOffset = -0.01;
    [repLayer addSublayer:replicatorView.layer];
    [self.bgScroll.layer addSublayer:repLayer];
    
    

    CABasicAnimation * scaleAni = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAni.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0, 0, 0)];
    scaleAni.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1, 1, 0)];
  

    
    CABasicAnimation *alpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alpha.fromValue = @(1.0);
    alpha.toValue = @(0.0);
    
    CAShapeLayer * circleLayer = [CAShapeLayer layer];
    circleLayer.frame = CGRectMake(0, 0, 80, 80);
    circleLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 80, 80)].CGPath;
    circleLayer.fillColor = [UIColor redColor].CGColor;
    circleLayer.opacity = 0;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[alpha,scaleAni];
    animationGroup.duration = 4.0;
    animationGroup.autoreverses = NO;
    animationGroup.repeatCount = HUGE;
    [circleLayer addAnimation:animationGroup forKey:@"animationGroup"];
 

    [circleLayer addAnimation:scaleAni forKey:@"scaleAni"];
    CAReplicatorLayer * circleRep = [CAReplicatorLayer layer];
    circleRep.frame = CGRectMake(0, 820, 80, 80);
    circleRep.instanceCount = 8;
    circleRep.instanceDelay = 0.5;
    [circleRep addSublayer:circleLayer];
    [self.bgScroll .layer addSublayer:circleRep];
    
    
    
    CAReplicatorLayer * waveRep = [CAReplicatorLayer layer];
    waveRep.frame = CGRectMake(100, 820, 80, 80);
    waveRep.instanceTransform = CATransform3DMakeTranslation(30, 0, 0);
    waveRep.instanceCount = 5;
    waveRep.instanceDelay = 0.5;
    [self.bgScroll .layer addSublayer:waveRep];
    
    CAShapeLayer * waveShape = [CAShapeLayer layer];
    waveShape.frame = CGRectMake(0, 0, 20, 20);
    waveShape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 20, 20)].CGPath;
    waveShape.fillColor = [UIColor redColor].CGColor;
    [waveRep addSublayer:waveShape];
    
    CABasicAnimation * waveAni = [CABasicAnimation animationWithKeyPath:@"transform"];
    waveAni.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.2, 0.2, 0)];
    waveAni.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 0)];
    waveAni.autoreverses = YES;
    waveAni.repeatCount = HUGE;
    waveAni.duration = 1;
    [waveShape addAnimation:waveAni forKey:@"waveAni"];
    
  
}

#pragma mark caemmiterLayer
-(void)caSnowEmmiterLayer{
    CAEmitterLayer * snowEmitter = [CAEmitterLayer layer];
    snowEmitter.emitterSize = CGSizeMake(kScreenWidth, 0); //发射器的尺寸
    snowEmitter.emitterMode = kCAEmitterLayerOutline;   //发射器发射模式
    snowEmitter.emitterShape = kCAEmitterLayerLine;   //发射器的形状
    snowEmitter.emitterPosition = CGPointMake(kScreenWidth/2, 30);//发射器 位置
    snowEmitter.renderMode = kCAEmitterLayerUnordered;//发射器渲染模式
    
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    snowflake.birthRate        = 2;//粒子产生速度  /s
    snowflake.lifetime        = 30.0;//粒子持续时间
    snowflake.velocity        = -10;                // falling down slowly粒子运动速度
    snowflake.velocityRange = 10;  //速度范围
    snowflake.yAcceleration = 2;  //粒子y方向的加速度分量
    snowflake.emissionRange = 0.5 * M_PI;        // some variation in angle 粒子发射角度范围
    snowflake.spinRange        = 0.25 * M_PI;        // slow spin 旋转角度
    
    snowflake.contents        = (id) [[UIImage imageNamed:@"DazFlake"] CGImage];
    snowflake.color            = [[UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:1.000] CGColor];
    
    // Make the flakes seem inset in the background
    snowEmitter.shadowOpacity = 1.0;
    snowEmitter.shadowRadius  = 0.0;
    snowEmitter.shadowOffset  = CGSizeMake(0.0, 1.0);
    snowEmitter.shadowColor   = [[UIColor whiteColor] CGColor];
    
    // Add everything to our backing layer below the UIContol defined in the storyboard
    snowEmitter.emitterCells = [NSArray arrayWithObject:snowflake];
    [self.bgScroll.layer insertSublayer:snowEmitter atIndex:0];
}

-(void)caSmogFireEmitterLayer{
    
}



#pragma mark catransformlayer
-(void)catransformLayer{
    //set up the perspective transform
    UIView * containView = [UIView new];
    containView.frame = CGRectMake(150, 250, 100, 100);
//    containView.backgroundColor = [UIColor redColor];
    [self.bgScroll addSubview:containView];
    CATransform3D pt = CATransform3DIdentity;
    pt.m34 = -1.0 / 500.0;
    containView.layer.sublayerTransform = pt;
    //set up the transform for cube 1 and add it
    CATransform3D c1t = CATransform3DIdentity;
    c1t = CATransform3DTranslate(c1t, -100, 0, 0);
    CALayer *cube1 = [self cubeWithTransform:c1t];
    [containView.layer addSublayer:cube1];
    //set up the transform for cube 2 and add it
    
    CATransform3D c2t = CATransform3DIdentity;
    c2t = CATransform3DTranslate(c2t, 100, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 1, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 0, 1, 0);
    CALayer *cube2 = [self cubeWithTransform:c2t];
    [containView.layer addSublayer:cube2];
}
- (CALayer *)faceWithTransform:(CATransform3D)transform {
    //create cube face layer
    CALayer *face = [CALayer layer];
    face.frame = CGRectMake(-50, -50, 100, 100);
    //apply a random color
    CGFloat red = (rand() / (double)INT_MAX);
    CGFloat green = (rand() / (double)INT_MAX);
    CGFloat blue = (rand() / (double)INT_MAX);
    face.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    //apply the transform and return
    face.transform = transform;
    return face;
}
- (CALayer *)cubeWithTransform:(CATransform3D)transform {
    //create cube layer
    CATransformLayer *cube = [CATransformLayer layer];
    //add cube face 1
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 2
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 3
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 4
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 5
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 6
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    //center the cube layer within the container
    CGSize containerSize = CGSizeMake(100, 100);
    cube.position = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    //apply the transform and return
    cube.transform = transform;
    return cube;
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
