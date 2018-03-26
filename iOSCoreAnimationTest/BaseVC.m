//
//  BaseVC.m
//  AnimationDemo
//
//  Created by 李清娟 on 2017/8/17.
//  Copyright © 2017年 --. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.bgScroll = [[UIScrollView alloc]init];
    self.bgScroll.backgroundColor = RandomColor(1);
    self.bgScroll.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.bgScroll];

    self.bgScroll.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
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
