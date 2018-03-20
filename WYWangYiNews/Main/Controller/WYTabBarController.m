//
//  WYTabBarController.m
//  WYWangYiNews
//
//  Created by 王云 on 2018/3/20.
//  Copyright © 2018年 王云. All rights reserved.
//

#import "WYTabBarController.h"
#import "UIColor+Addition.h"
@interface WYTabBarController ()

@end

@implementation WYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewControllers];
    
}


-(void)addChildViewControllers
{
    NSArray *array = @[
                       @{@"clsName": @"WYHomeViewController", @"title": @"新闻", @"imageName": @"news"},
                       @{@"clsName": @"UIViewController", @"title": @"阅读", @"imageName": @"reader"},
                       @{@"clsName": @"UIViewController", @"title": @"视频", @"imageName": @"media"},
                       @{@"clsName": @"UIViewController", @"title": @"话题", @"imageName": @"bar"},
                       @{@"clsName": @"UIViewController", @"title": @"我", @"imageName": @"me"},];
    for (NSDictionary *dict in array) {
        UIViewController *vc = [self addChildViewControllerWithDict:dict];
        if ([dict[@"title"] isEqualToString:@"新闻"]) {
            vc.view.backgroundColor = [UIColor whiteColor];
        }else
        {
            vc.view.backgroundColor = [UIColor randomColor];
        }
        
        [self addChildViewController:vc];
    }
    
    
}

-(UIViewController *)addChildViewControllerWithDict:(NSDictionary *)dict
{
    UIViewController *vc = [NSClassFromString(dict[@"clsName"]) new];
    vc.title = dict[@"title"];
    vc.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar_icon_%@_highlight", dict[@"imageName"]]];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar_icon_%@_highlight", dict[@"imageName"]]];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    return nav;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
