//
//  TeacherModel.h
//  newProject
//
//  Created by TranDucY on 8/15/18.
//  Copyright © 2018 TranDucY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeacherModel : NSObject
@property (nonatomic,strong) NSString *nameContact;
@property (nonatomic,strong) NSString *phoneContact;
@property (nonatomic,strong) NSString *pathImage;
@property (nonatomic,strong) NSString *emailContact;


+ (NSArray *)dummyData;

//1. database
//2. backend
//3. firebase

@end
