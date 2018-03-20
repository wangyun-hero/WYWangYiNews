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
    WYChannelLabel *label = [WYChannelLabel labelWithText:labelMoel.title andTextColor:[UIColor redColor] andFontSize:18];
    [label sizeToFit];
    return label;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
