//
//  DetailsVC.m
//  newProject
//
//  Created by TranDucY on 8/16/18.
//  Copyright © 2018 TranDucY. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "DetailsVC.h"
#import "AccountCell.h"
#import "TeacherModel.h"
@interface DetailsVC ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contactImage;

@property (nonatomic,strong) NSArray *arrayDetailContact;
@property (weak, nonatomic) IBOutlet UIButton *fixButon;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end
@implementation DetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLabel.text = self.model.nameContact;
    self.phoneLabel.text = self.model.phoneContact;
    self.emailLabel.text = self.model.emailContact;
    self.contactImage.image = [UIImage imageNamed:self.model.pathImage];
    // Do any additional setup after loading the view.
}

- (void)showDetailWithTeacher:(TeacherModel *)data{
    self.nameLabel.text = data.nameContact;
    self.phoneLabel.text = data.phoneContact;
    self.emailLabel.text = data.emailContact;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)deleteTeacherAction:(id)sender {
    if([self.delegate respondsToSelector:@selector(didClickDeleteTeacher:)]) {
        [self.delegate didClickDeleteTeacher:self.model];
        [self.navigationController
         popViewControllerAnimated:YES];
    }
}

@end
