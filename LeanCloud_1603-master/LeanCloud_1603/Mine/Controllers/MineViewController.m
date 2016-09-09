//
//  MineViewController.m
//  LeanCloud_1603
//
//  Created by Chaosky on 16/9/8.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import "MineViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "TuicoolUser.h"

@interface MineViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    TuicoolUser * currentUser = [TuicoolUser currentUser];
    if (currentUser) {
        self.nickNameLabel.text = currentUser.nickName;
//        self.avatarImageView
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 登录或者查看详情
- (void)checkUserInfo {
    if ([TuicoolUser currentUser]) {
        [self performSegueWithIdentifier:@"UserInfoSegue" sender:nil];
    }
    else {
        [self performSegueWithIdentifier:@"LoginSegue" sender:nil];
    }
}

#pragma UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        NSLog(@"登录或者查看详情");
        [self checkUserInfo];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
