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
#import "EditVC.h"
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
#pragma mark - Lifecyle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLabel.text = self.model.nameContact;
    self.phoneLabel.text = self.model.phoneContact;
    self.emailLabel.text = self.model.emailContact;
    self.contactImage.image = [UIImage imageNamed:self.model.pathImage];
    // Do any additional setup after loading the view.
}
#pragma mark - Show data
- (void)showDetailWithTeacher:(TeacherModel *)data{
    self.nameLabel.text = data.nameContact;
    self.phoneLabel.text = data.phoneContact;
    self.emailLabel.text = data.emailContact;
}

#pragma mark - gesture
- (IBAction)deleteTeacherAction:(id)sender {
    if([self.delegate respondsToSelector:@selector(didClickDeleteTeacher:)]) {
        [self.delegate didClickDeleteTeacher:self.model];
        NSLog(@"7");
        [self.navigationController popViewControllerAnimated:YES];
      //[self.navigationController popToRootViewControllerAnimated:YES];
        NSLog(@"POPED!");
    }
}

- (IBAction)didClickEditButton:(id)sender {
    EditVC  *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"EditVC"];
    edit.model = [[TeacherModel alloc]init];
    edit.model = self.model;
    [self.navigationController pushViewController:edit animated:YES];
}
@end
