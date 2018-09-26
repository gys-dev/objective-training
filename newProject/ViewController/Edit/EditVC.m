//
//  EditVC.m
//  newProject
//
//  Created by TranDucY on 8/27/18.
//  Copyright © 2018 TranDucY. All rights reserved.
//

#import "EditVC.h"
#import "TeacherModel.h"
#import "HomeVC.h"
@interface EditVC ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *imageTextField;
- (IBAction)didClickEdit:(id)sender;
@property (strong,nonatomic) TeacherModel *dataSend;
@end

@implementation EditVC
#pragma mark - lifecyle
- (void)viewDidLoad {
    [super viewDidLoad];
    TeacherModel *data = [[TeacherModel alloc]init];
    self.dataSend = [[TeacherModel alloc] init];
    data = self.model;
    self.nameTextField.text = data.nameContact;
    self.phoneTextField.text = data.phoneContact;
    self.emailTextField.text = data.emailContact;
    self.imageTextField.text = data.pathImage;
}
#pragma mark - gesture
- (IBAction)didClickEdit:(id)sender {
    HomeVC *home  =[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    self.dataSend.nameContact = self.nameTextField.text;
    self.dataSend.phoneContact = self.phoneTextField.text;
    self.dataSend.emailContact = self.emailTextField.text;
    self.dataSend.pathImage = self.imageTextField.text;
    self.dataSend.idContact = self.model.idContact;
    NSMutableDictionary *dic  = [[NSMutableDictionary alloc] init];
    [dic setObject:self.dataSend forKey:@"moi"];
    [dic setObject:self.model forKey:@"cu"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didClickEdit" object:dic];
//    [self.navigationController pushViewController:home animated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
@end
