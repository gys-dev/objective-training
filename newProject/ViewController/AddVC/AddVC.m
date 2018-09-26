//
//  AddVC.m
//  newProject
//
//  Created by TranDucY on 8/24/18.
//  Copyright © 2018 TranDucY. All rights reserved.
//

#import "AddVC.h"
#import "TeacherModel.h"

@interface AddVC ()<UIAlertViewDelegate>

@property (nonatomic,strong) TeacherModel *model;

@end

@implementation AddVC
#pragma mark - Lifecyle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Add New Contact";
    self.model = [[TeacherModel alloc] init];
}
#pragma mark - gesture
- (IBAction)clickAdd:(id)sender {
    if ([self checkNameCorrect:self.nameTextField.text]){
        self.model.nameContact = self.nameTextField.text;
        self.model.phoneContact = self.phoneTextField.text;
        self.model.emailContact = self.emailTextField.text;
        self.model.pathImage = self.imageTextField.text;
        if  ([self.delegate respondsToSelector:@selector(addNewData:)]){
            [self.delegate addNewData:self.model];
            [self.navigationController popViewControllerAnimated:YES];
            //       [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }else{
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Wrong paramater"
                                     message:@"You must type your fullname"
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle no, thanks button
                                    }];;
        [alert addAction:okButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}
#pragma mark - Helper
- (bool)checkNameCorrect:(NSString *)nameContact{
    for (int i = 0; i < [nameContact length]; i++){
        if (([nameContact characterAtIndex:i]  == ' ' && [nameContact characterAtIndex:i+1] != ' '))
            return true;
    }
    return false;
}
@end
