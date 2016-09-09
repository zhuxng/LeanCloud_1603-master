//
//  RegisterViewController.m
//  LeanCloud_1603
//
//  Created by Chaosky on 16/9/8.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import "RegisterViewController.h"
#import "TuicoolUser.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nickNameTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *passwdTF;
@property (weak, nonatomic) IBOutlet UITextField *repeatPasswdTF;
- (IBAction)registerAction:(UIBarButtonItem *)sender;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)registerAction:(UIBarButtonItem *)sender {
    NSString * nickName = self.nickNameTF.text;
    NSString * email = self.emailTF.text;
    NSString * passwd = self.passwdTF.text;
    NSString * repeatPasswd = self.repeatPasswdTF.text;
    
    if (nickName.length == 0 || email.length == 0 || passwd.length == 0 || repeatPasswd.length == 0) {
        return;
    }
    
    if (passwd.length < 6 || passwd.length > 12) {
        return;
    }
    
    if (![passwd isEqualToString:repeatPasswd]) {
        return;
    }
    
    // 用正则表达式验证邮箱
    NSString * emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    // 谓词：匹配条件
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    if (![emailPredicate evaluateWithObject:email]) {
        return;
    }
    
    TuicoolUser * user = [TuicoolUser user];
    user.username = email;
    user.email = email;
    user.nickName = nickName;
    user.password = passwd;
    
    // 将weakSelf变量指向self，但是不会引起引用计数+1
    __weak typeof(self) weakSelf = self;
//    __weak RegisterViewController * weakSelf = self;
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"注册成功，返回登录");
            // 登出，注册成功当做登录了。
            [TuicoolUser logOut];
            
            // 反向传值
            if (weakSelf.block) {
                weakSelf.block(email);
            }
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
        else {
            NSLog(@"注册失败，错误信息%@", error.localizedDescription);
        }
    }];
    
}
@end
