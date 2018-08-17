//
//  TeacherModel.m
//  newProject
//
//  Created by TranDucY on 8/15/18.
//  Copyright © 2018 TranDucY. All rights reserved.
//

#import "TeacherModel.h"

@interface TeacherModel()

@end

@implementation TeacherModel

+ (NSArray *)dummyData {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    // data1
    TeacherModel *contact = [[TeacherModel alloc]init];
    contact.nameContact = @"Tran Duc Y";
    contact.phoneContact = @"0123445677887";
    contact.pathImage = @"1.jpeg";
    contact.emailContact = @"dujksajdk@gmail.com";
    [arr addObject:contact];
    
    //data2
    TeacherModel *contact1 = [[TeacherModel alloc]init];
    contact1.nameContact = @"Nguyen Van A";
    contact1.phoneContact = @"01232398433";
    contact1.pathImage = @"2.jpg";
    contact.emailContact = @"dujksajdk@gmail.com";
    [arr addObject:contact1];
    // data1
    TeacherModel *contact2 = [[TeacherModel alloc]init];
    contact2.nameContact = @"Tran Duc Y";
    contact2.phoneContact = @"0123445677887";
    contact2.pathImage = @"1.jpeg";
    contact2.emailContact = @"dujksajdk@gmail.com";
    [arr addObject:contact2];
    
    //data2
    TeacherModel *contact3 = [[TeacherModel alloc]init];
    contact3.nameContact = @"Nguyen Van A";
    contact3.phoneContact = @"01232398433";
    contact3.pathImage = @"2.jpg";
    contact3.emailContact = @"dujksajdk@gmail.com";
    [arr addObject:contact3];
    return arr;
}

@end
