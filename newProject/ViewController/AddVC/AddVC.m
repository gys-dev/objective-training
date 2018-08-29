//
//  AddVC.m
//  newProject
//
//  Created by TranDucY on 8/24/18.
//  Copyright © 2018 TranDucY. All rights reserved.
//

#import "AddVC.h"
#import "TeacherModel.h"

@interface AddVC ()

@property (nonatomic,strong) TeacherModel *model;

@end

@implementation AddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Add New Contact";
    self.model = [[TeacherModel alloc] init];
}

- (IBAction)clickAdd:(id)sender {
    self.model.nameContact = self.nameTextField.text;
    self.model.phoneContact = self.phoneTextField.text;
    self.model.emailContact = self.emailTextField.text;
    self.model.pathImage = self.imageTextField.text;
    if  ([self.delegate respondsToSelector:@selector(addNewData:)]){
        [self.delegate addNewData:self.model];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
