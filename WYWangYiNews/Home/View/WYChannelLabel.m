//
//  WYChannelLabel.m
//  WYWangYiNews
//
//  Created by 王云 on 2018/3/20.
//  Copyright © 2018年 王云. All rights reserved.
//

#import "WYChannelLabel.h"
#import "UILabel+Addition.h"
@implementation WYChannelLabel
+(instancetype)labelWithModel:(WYHomeLabelModel *)labelMoel
{
    WYChannelLabel *label = [WYChannelLabel labelWithText:labelMoel.title andTextColor:[UIColor blackColor] andFontSize:18];
    // 计算好大小之后变为14
    [label sizeToFit];
    label.font = [UIFont systemFontOfSize:14];
    return label;
}

-(void)setScale:(CGFloat)scale
{
    _scale = scale;
    [self setTextColor:[UIColor colorWithRed:scale green:0 blue:0 alpha:1]];
    
    CGFloat sc = 14 + (18 - 14) * scale;
    self.transform = CGAffineTransformMakeScale(sc/14, sc/14);
}

@end
