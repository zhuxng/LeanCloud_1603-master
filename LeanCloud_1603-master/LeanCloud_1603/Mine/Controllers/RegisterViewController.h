//
//  RegisterViewController.h
//  LeanCloud_1603
//
//  Created by Chaosky on 16/9/8.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UserInfoBlock)(NSString * email);

@interface RegisterViewController : UIViewController

@property (nonatomic, copy) UserInfoBlock block;

@end
