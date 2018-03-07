//
//  Layer1VC.m
//  iOSCoreAnimationTest
//
//  Created by 左晓东 on 2018/3/1.
//  Copyright © 2018年 ZXD. All rights reserved.
//

#import "Layer1VC.h"

@interface Layer1VC ()
@property (nonatomic,strong)UIView * layerView;
@property (nonatomic,strong)CALayer * blueLayer;
@property (nonatomic,strong)UIImageView * clockIV;
@property (nonatomic,strong)UIImageView * hourIV;
@property (nonatomic,strong)UIImageView * minuteIV;
@property (nonatomic,strong)UIImageView * secondIV;
@property (nonatomic,strong)NSTimer * timer;
@end

@implementation Layer1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"图层的树状结构";
    self.blueLayer = [CALayer layer];
    self.blueLayer.frame = CGRectMake(25, 25, 50, 50);
    self.blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layerView.layer addSublayer:self.blueLayer];
    self.blueLayer.contents = (__bridge id)[UIImage imageNamed:@"光荣大地"].CGImage;
    //如果不加👇这行代码，图片会变形 被拉伸，下面这行代码类似于 uiview 的contentmode
    self.blueLayer.contentsGravity = kCAGravityResizeAspect;
//    self.blueLayer.contentsGravity = kCAGravityCenter;
//    self.blueLayer.contentsScale = [UIImage imageNamed:@"光荣大地"].scale;
//    self.blueLayer.masksToBounds = YES;
    
    
    //当对图层做变换的时候，比如旋转或者缩放,frame实际上代表了覆盖在图层旋转之后的整个轴对齐的矩形区域，也就是说frame 的宽高可能和bounds的宽高不再一致了
    //self.layerView.frame1 = {{100, 50}, {100, 100}}
    NSLog(@"self.layerView.frame1 = %@",NSStringFromCGRect(self.layerView.frame));
    CGAffineTransform affineTransform = CGAffineTransformIdentity;
    self.layerView.layer.affineTransform = CGAffineTransformRotate(affineTransform, M_PI_4);
    //self.layerView.frame2 = {{79.289321881345259, 29.289321881345245}, {141.42135623730951, 141.42135623730951}}
    NSLog(@"self.layerView.frame2 = %@",NSStringFromCGRect(self.layerView.frame));
    
    
    [self setupClock];
    
}

//时钟，测试archPoint
-(void)setupClock{
    self.clockIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"clock"]];
    
    self.hourIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hour"]];
    self.minuteIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"minute"]];
    self.secondIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"second"]];

   
    [self.bgScroll addSubview:self.clockIV];
    [self.clockIV addSubview:self.hourIV];
    [self.clockIV addSubview:self.minuteIV];
    [self.clockIV addSubview:self.secondIV];
    [self.clockIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake( 326, 321));
        make.top.mas_equalTo(200);
        make.centerX.equalTo(self.bgScroll);
    }];
    [self.hourIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(39, 142));
        make.center.equalTo(self.clockIV);
    }];
    [self.minuteIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 156));
        make.center.equalTo(self.clockIV);
    }];
    [self.secondIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(13, 147));
        make.center.equalTo(self.clockIV);
    }];
    self.hourIV.layer.anchorPoint = CGPointMake(0.5, 1);
    self.minuteIV.layer.anchorPoint = CGPointMake(0.5, 1);
    self.secondIV.layer.anchorPoint = CGPointMake(0.5, 1);

    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];

}

- (void)tick {
    //convert time to hours, minutes and seconds
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger units = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    CGFloat hoursAngle = (components.hour / 12.0) * M_PI * 2.0; //calculate hour hand angle
    //calculate minute hand angle
    CGFloat minsAngle = (components.minute / 60.0) * M_PI * 2.0;
    //calculate second hand angle
    CGFloat secsAngle = (components.second / 60.0) * M_PI * 2.0;
    //rotate hands
    self.hourIV.transform = CGAffineTransformMakeRotation(hoursAngle);
    self.minuteIV.transform = CGAffineTransformMakeRotation(minsAngle);
    self.secondIV.transform = CGAffineTransformMakeRotation(secsAngle);
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject]locationInView:self.bgScroll];
    point = [self.layerView.layer convertPoint:point fromLayer:self.bgScroll.layer];
//    if ([self.layerView.layer containsPoint:point]) {
//        point = [self.blueLayer convertPoint:point fromLayer:self.layerView.layer];
//        if ([self.blueLayer containsPoint:point]) {
//            [[[UIAlertView alloc] initWithTitle:@"Inside Blue Layer" message:nil
//                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//        }else{
//            [[[UIAlertView alloc] initWithTitle:@"inside layerVIew Layer" message:nil
//                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//        }
//    }else{
//        [[[UIAlertView alloc] initWithTitle:@"outside layerview Layer" message:nil
//                                   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//    }
    
    CALayer * layer = [self.layerView.layer hitTest:point];
    if (layer==self.blueLayer) {
        //..
    }
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.timer&&[self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
-(void)dealloc{
   
    NSLog(@"跳出 dealloc");
}

-(UIView *)layerView{
    if (!_layerView) {
        _layerView = [UIView new];
        _layerView.backgroundColor = [UIColor redColor];
        _layerView.frame = CGRectMake(100, 50, 100, 100);
        [self.bgScroll addSubview:_layerView];
        
    }
    return _layerView;
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
