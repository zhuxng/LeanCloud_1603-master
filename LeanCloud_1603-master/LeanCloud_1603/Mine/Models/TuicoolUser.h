//
//  TuicoolUser.h
//  LeanCloud_1603
//
//  Created by Chaosky on 16/9/8.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud.h>

// 子类化自定义类
@interface TuicoolUser : AVUser<AVSubclassing>

@property (retain) NSString * nickName; // 昵称
@property (retain) NSString * avatarUrl; // 头像

@end
