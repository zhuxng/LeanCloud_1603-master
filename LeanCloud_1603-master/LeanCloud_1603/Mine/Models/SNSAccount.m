//
//  SNSAccount.m
//  LeanCloud_1603
//
//  Created by Chaosky on 16/9/9.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import "SNSAccount.h"

@implementation SNSAccount

@dynamic platformName;
@dynamic userName;
@dynamic appUserID;
@dynamic userID;
@dynamic iconURL;

+ (NSString *)parseClassName
{
    return @"SNSAccount";
}

@end
