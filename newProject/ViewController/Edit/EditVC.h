//
//  EditVC.h
//  newProject
//
//  Created by TranDucY on 8/27/18.
//  Copyright © 2018 TranDucY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TeacherModel;
@protocol EditVCDelegate <NSObject>
- (void) editSend:(TeacherModel* )dataSend;
@end

@interface EditVC : UIViewController
@property (strong, nonatomic) TeacherModel *model;

@property (nonatomic,weak) id <EditVCDelegate> delegate;

@end
