//
//  AddVC.h
//  newProject
//
//  Created by TranDucY on 8/24/18.
//  Copyright © 2018 TranDucY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TeacherModel;
@protocol AddVCDelegate <NSObject>
- (void)addNewData:(TeacherModel *) model;
@end
@interface AddVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *imageTextField;

@property (weak, nonatomic) id <AddVCDelegate> delegate;
@end
