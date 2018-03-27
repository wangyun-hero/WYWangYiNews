//
//  WYChannelView.h
//  WYWangYiNews
//
//  Created by 王云 on 2018/3/20.
//  Copyright © 2018年 王云. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYChannelView;
//1 协议
@protocol ChannelViewDelegate <NSObject>
//2 代理方法
- (void)channelView:(WYChannelView *)channelView clickWithIndex:(NSInteger)index;

@end
@interface WYChannelView : UIView

@property(nonatomic,strong) NSMutableArray *channelArray;
//3 声明代理属性
@property(nonatomic,weak) id<ChannelViewDelegate>delegate;
+(instancetype)channelView;

-(void)setScale:(CGFloat)scale withIndex:(NSInteger)index;
@end
