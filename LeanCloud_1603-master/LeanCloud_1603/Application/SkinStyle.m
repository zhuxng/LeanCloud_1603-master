//
//  SkinStyle.m
//  LeanCloud_1603
//
//  Created by Chaosky on 16/9/8.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import "SkinStyle.h"
#import "UtilsMacro.h"

@implementation SkinStyle

+ (UIColor *)navigationBarColor
{
    return RGBColor(45, 170, 144);
}

+ (UIColor *)tabBarColor {
    return RGBColor(45, 170, 144);
}

+ (UIColor *)backgroundColor
{
    return RGBColor(249, 247, 250);
}

+ (void)configSkinStyle
{
    // TabBar
    [UITabBar appearance].tintColor = [self tabBarColor];
    // Navigation Bar
    [UINavigationBar appearance].barTintColor = [self navigationBarColor];
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
}

@end
