//
//  BaseVC.h
//  AnimationDemo
//
//  Created by 李清娟 on 2017/8/17.
//  Copyright © 2017年 --. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

#define RandomColor(a) [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:a]

#define kScreenWidth [UIScreen mainScreen].bounds.size.width


#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface BaseVC : UIViewController
@property (nonatomic,strong)UIScrollView * bgScroll;
@end
