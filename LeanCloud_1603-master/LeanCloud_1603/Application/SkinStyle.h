//
//  SkinStyle.h
//  LeanCloud_1603
//
//  Created by Chaosky on 16/9/8.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SkinStyle : NSObject

+ (UIColor *)navigationBarColor;
+ (UIColor *)tabBarColor;
+ (UIColor *)backgroundColor;

// 配置皮肤
+ (void)configSkinStyle;

@end
