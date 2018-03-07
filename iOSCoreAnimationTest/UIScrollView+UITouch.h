//
//  UIScrollView+UITouch.h
//  iOSCoreAnimationTest
//
//  Created by 左晓东 on 2018/3/1.
//  Copyright © 2018年 ZXD. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
touchesBegan: withEvent: / touchesMoved: withEvent: / touchesEnded: withEvent: 等只能被UIView捕获（如有问题请指出对请指出，路过的大牛请勿喷），当我们创建
UIScrollView 或 UIImageView 时，当点击时UIScrollView 或 UIImageView 会截获touch事件，导致touchesBegan: withEvent:/touchesMoved: withEvent:/touchesEnded: withEvent: 等方法不执行。解决办法：当UIScrollView 或 UIImageView 截获touch事件后，让其传递下去即可（就是传递给其父视图UIView）
可以通过写UIScrollView 或 UIImageView 的category 重写touchesBegan: withEvent: / touchesMoved: withEvent: / touchesEnded: withEvent: 等来实现
 */
@interface UIScrollView (UITouch)

@end
