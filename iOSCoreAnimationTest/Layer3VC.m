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
    [self setupShapeLayer];
    [self setupTextLayer];
    // Do any additional setup after loading the view.
}
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
    
    LayerLabel * layerLab = [[LayerLabel alloc]initWithFrame:CGRectMake(270, 80, 40, 280)];
    layerLab.numberOfLines = 0;
    layerLab.textColor = [UIColor yellowColor];
    layerLab.backgroundColor = [UIColor blueColor];
    layerLab.font = [UIFont systemFontOfSize:13];
    layerLab.text = @"三点减肥那是的光华科技环球文化阿斯顿好看讲话稿考好点你能干啥规划师的好";
//    [layerLab sizeToFit];

    [self.bgScroll addSubview:layerLab];
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
