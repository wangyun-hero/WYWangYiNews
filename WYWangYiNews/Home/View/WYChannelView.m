//
//  WYChannelView.m
//  WYWangYiNews
//
//  Created by 王云 on 2018/3/20.
//  Copyright © 2018年 王云. All rights reserved.
//

#import "WYChannelView.h"
#import "WYChannelLabel.h"
@interface WYChannelView()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@end

@implementation WYChannelView
+(instancetype)channelView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"WYChannelView"
                                          owner:nil
                                        options:nil] lastObject];
}

-(void)setChannelArray:(NSMutableArray *)channelArray
{
    _channelArray = channelArray;
    CGFloat margin = 10;
    CGFloat x = margin;
    for (int i = 0; i < channelArray.count; i++) {
        WYHomeLabelModel *labelModel = [channelArray objectAtIndex:i];
        WYChannelLabel *label = [WYChannelLabel labelWithModel:labelModel];
//        [self.scrollview addSubview:label];
        label.frame = CGRectMake(x, 0, label.frame.size.width, 35);
        [self.scrollview addSubview:label];
        x += label.frame.size.width + margin;
    }
    self.scrollview.contentSize = CGSizeMake(x, 0);
    
}

@end