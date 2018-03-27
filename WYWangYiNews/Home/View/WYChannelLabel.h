//
//  WYChannelLabel.h
//  WYWangYiNews
//
//  Created by 王云 on 2018/3/20.
//  Copyright © 2018年 王云. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYHomeLabelModel.h"
@interface WYChannelLabel : UILabel
@property(nonatomic,assign) CGFloat scale;
+(instancetype)labelWithModel:(WYHomeLabelModel *)labelMoel;
@end
