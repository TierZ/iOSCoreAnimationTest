//
//  Layer2VC.m
//  iOSCoreAnimationTest
//
//  Created by 左晓东 on 2018/3/2.
//  Copyright © 2018年 ZXD. All rights reserved.
//

#import "Layer2VC.h"

@interface Layer2VC ()
@property (nonatomic,strong)UIView * layerView;
@property (nonatomic,strong)UIView * subLayerView;
@end

@implementation Layer2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"视觉效果 & 变换";
    // Do any additional setup after loading the view.
    [self setupView];
    [self transform];
}
-(void)setupView{
    [self.layerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(50);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    [self.subLayerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    self.layerView.layer.cornerRadius = 5;

    self.subLayerView.layer.cornerRadius = 5;
    self.layerView.layer.masksToBounds = YES;//添加后会把多余的部分裁剪掉
//    self.layerView.layer.borderWidth = 2;
//    self.layerView.layer.borderColor = [UIColor blueColor].CGColor;
    self.subLayerView.layer.borderWidth = 2;
    self.subLayerView.layer.borderColor = [UIColor greenColor].CGColor;
    
//    self.layerView.layer.shadowOpacity = 0.5;
//    self.layerView.layer.shadowOffset = CGSizeMake(5, 5);
//    self.layerView.layer.shadowRadius = 5;
    
    //解决 既有阴影 又有圆角的问题
    CALayer * shadowLayer = [CALayer layer];
    shadowLayer.frame = CGRectMake(50, 50, 100, 100);
   
    [self.bgScroll.layer insertSublayer:shadowLayer below:self.layerView.layer];
    shadowLayer.shadowOpacity = 0.5;
    shadowLayer.shadowOffset = CGSizeMake(5, 5);
    shadowLayer.shadowRadius = 5;
    shadowLayer.backgroundColor = [UIColor whiteColor].CGColor;
    shadowLayer.shadowColor = [UIColor blackColor].CGColor;
    shadowLayer.cornerRadius = 5;
    
    
    //组透明 设置 shouldRasterize
    
    UIView * view1 = [UIView new];
    view1.backgroundColor = [UIColor whiteColor];
    [self.bgScroll addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgScroll).offset(50);
        make.left.equalTo(self.bgScroll).offset(200);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
//    label.backgroundColor = [UIColor lightGrayColor];
    label.text = @"Hello World";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [view1 addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(40, 10, 40, 10));
    }];
    view1.layer.shouldRasterize = YES;
    view1.layer.rasterizationScale = [UIScreen mainScreen].scale;
    view1.alpha = 0.5;

    
}

-(void)transform{
    UIImageView * iv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"456.png"]];
    iv.backgroundColor = [UIColor yellowColor];
    
    iv.contentMode = UIViewContentModeScaleAspectFit;
    [self.bgScroll addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.top.equalTo(self.layerView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, 20, 20);
    transform = CGAffineTransformScale(transform, 0.8, 0.8);
    transform = CGAffineTransformRotate(transform, M_PI_4);
    iv.layer.affineTransform = transform;
    NSLog(@"m_pi_4 = %f",M_PI_4);
    
    
    UIView * view2 = [UIView new];
    view2.backgroundColor = [UIColor greenColor];
    [self.bgScroll addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iv);
        make.left.equalTo(iv.mas_right).offset(80);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    CATransform3D transform3D = CATransform3DIdentity;
    transform3D.m34 = -1/500.0;
    transform3D = CATransform3DRotate(transform3D, M_PI_4, 0, 1, 0);
    transform3D = CATransform3DScale(transform3D, 0.8, 0.8, 1);
    transform3D = CATransform3DTranslate(transform3D, 50, 50, 50);
    view2.layer.transform = transform3D;
    
    
    
    
    
}

-(UIView *)layerView{
    if (!_layerView) {
        _layerView = [UIView new];
        _layerView.backgroundColor = [UIColor whiteColor];
        [self.bgScroll addSubview:_layerView];
    }
    return _layerView;
}
-(UIView *)subLayerView{
    if (!_subLayerView) {
        _subLayerView = [UIView new];
        _subLayerView.backgroundColor = [UIColor redColor];
        [self.layerView addSubview:_subLayerView];
    }
    return _subLayerView;
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
