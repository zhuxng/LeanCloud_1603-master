//
//  LoginViewController.m
//  LeanCloud_1603
//
//  Created by Chaosky on 16/9/8.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "TuicoolUser.h"
#import "SNSAccount.h"
#import <MBProgressHUD.h>
#import <UMSocial.h>

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *passwdTF;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)loginAction:(UIButton *)sender;
- (IBAction)forgetPasswdAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *weiboLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *qqLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *weixinLoginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
}

- (void)setupView {
    _emailTF.delegate = self;
    _passwdTF.delegate = self;
    
    _loginButton.enabled = NO;
    
    [_weiboLoginButton addTarget:self action:@selector(weiboLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    [_qqLoginButton addTarget:self action:@selector(qqLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    [_weixinLoginButton addTarget:self action:@selector(weixinLoginAction:) forControlEvents:UIControlEventTouchUpInside];
}

// 数据库中用户表：http://wpceo.com/user-database-table-design/
- (void)weiboLoginAction:(UIButton *) sender {
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
            SNSAccount * tuicoolSNSAccount = [SNSAccount object];
            tuicoolSNSAccount.platformName = snsAccount.platformName;
            tuicoolSNSAccount.appUserID = snsAccount.usid;
            tuicoolSNSAccount.userName = snsAccount.userName;
            tuicoolSNSAccount.iconURL = snsAccount.iconURL;
            
            // 仅仅只是把用户表当做数据库表来存储，不使用注册功能
            TuicoolUser * user = [TuicoolUser user];
            NSDate * date = [NSDate date];
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddhhmmss";
            user.username = [formatter stringFromDate:date];
            user.password = @"123456";
            [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    tuicoolSNSAccount.userID = user.objectId;
                    
                    [tuicoolSNSAccount saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        
                    }];
                }
            }];
            
        }});
}

- (void)qqLoginAction:(UIButton *) sender {
    
}

- (void)weixinLoginAction:(UIButton *) sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"RegisterSegue"]) {
        RegisterViewController * registerVC = segue.destinationViewController;
        registerVC.block = ^(NSString * email) {
            
        };
    }
    
}

- (IBAction)loginAction:(UIButton *)sender {
    
    NSString * username = _emailTF.text;
    NSString * password = _passwdTF.text;
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    __weak typeof(self) weakSelf = self;
    [TuicoolUser logInWithUsernameInBackground:username password:password block:^(AVUser *user, NSError *error) {
        if (error) {
            hud.label.text = error.localizedDescription;
            [hud hideAnimated:YES afterDelay:1.0];
        }
        else {
            hud.label.text = @"登录成功";
            [hud hideAnimated:YES afterDelay:1.0];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
        
    }];
}

- (IBAction)forgetPasswdAction:(UIButton *)sender {
    // 打开链接
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.tuicool.com/settings/missing_pwd"]];
    // 打电话
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:18981988677"]];
    // 发短信
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms:10086"]];
    // 发邮件
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:352135591@qq.com"]];
    // 打开系统设置
    // 跳转到自己程序的设置界面
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    // 跳转系统设置
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
    // 应用程序之间跳转，要用到scheme
}


#pragma - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 未变更的文本
    NSString * oldText = textField.text;
    // 变更之后的文本
    NSString * newText = [oldText stringByReplacingCharactersInRange:range withString:string];
    
    NSString * otherText = textField == _emailTF ? _passwdTF.text : _emailTF.text;
    
    if (newText.length == 0 || otherText.length == 0) {
        _loginButton.enabled = NO;
    }
    else {
        _loginButton.enabled = YES;
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    _loginButton.enabled = YES;
    return YES;
}


@end
