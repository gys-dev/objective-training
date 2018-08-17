//
//  DetailsVC.h
//  newProject
//
//  Created by TranDucY on 8/16/18.
//  Copyright © 2018 TranDucY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TeacherModel;
@protocol DetailVCDelegate <NSObject>
- (void)didClickDeleteTeacher:(TeacherModel *)model;
@end

@interface DetailsVC : UIViewController

@property (nonatomic,weak) id<DetailVCDelegate>delegate;
@property (nonatomic, strong) TeacherModel *model;
- (void)showDetailWithTeacher:(TeacherModel *)data;

@end
