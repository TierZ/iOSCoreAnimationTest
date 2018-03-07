//
//  LayerLabel.m
//  iOSCoreAnimationTest
//
//  Created by 左晓东 on 2018/3/7.
//  Copyright © 2018年 ZXD. All rights reserved.
//

#import "LayerLabel.h"
@interface LayerLabel()
@property (nonatomic,strong)CATextLayer * textLayer;
@end
@implementation LayerLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(Class)layerClass{
    return [CATextLayer class];
}
-(CATextLayer *)textLayer{
    return (CATextLayer*)self.layer;
}
-(void)setup{
    self.text = self.text;
    self.textColor = self.textColor;
    self.font = self.font;
    
    self.textLayer.alignmentMode = kCAAlignmentLeft;
    self.textLayer.wrapped = YES;
    [self.layer display];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setText:(NSString *)text{
    super.text =text;
    self.textLayer.string = text;
}
-(void)setFont:(UIFont *)font{
    super.font = font;
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    self.textLayer.font =fontRef;
    self.textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
}

-(void)setTextColor:(UIColor *)textColor{
    super.textColor = textColor;
    self.textLayer.foregroundColor = textColor.CGColor;
}
-(void)setBackgroundColor:(UIColor *)backgroundColor{

    super.backgroundColor = [UIColor clearColor];
    self.textLayer.backgroundColor = backgroundColor.CGColor;
}
@end
