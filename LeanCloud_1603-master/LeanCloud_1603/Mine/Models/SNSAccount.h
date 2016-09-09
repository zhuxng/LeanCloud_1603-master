//
//  SNSAccount.h
//  LeanCloud_1603
//
//  Created by Chaosky on 16/9/9.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud.h>

@interface SNSAccount : AVObject<AVSubclassing>
@property (retain) NSString * platformName;

@property (retain) NSString * userName;

@property (retain) NSString * appUserID;

@property (retain) NSString * userID;

@property (retain) NSString * iconURL;

@end
