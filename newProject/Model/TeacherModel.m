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
    // data0
    TeacherModel *contact = [[TeacherModel alloc]init];
    contact.nameContact = @"Y";
    contact.phoneContact = @"0123445677887";
    contact.pathImage = @"1.jpeg";
    contact.emailContact = @"dujksajdk@gmail.com";
    [arr addObject:contact];
    
    //data1
    TeacherModel *contact1 = [[TeacherModel alloc]init];
    contact1.nameContact = @"Hoang Van A";
    contact1.phoneContact = @"01232398433";
    contact1.pathImage = @"2.jpg";
    contact.emailContact = @"dujksajdk@gmail.com";
    [arr addObject:contact1];
    // data2
    TeacherModel *contact2 = [[TeacherModel alloc]init];
    contact2.nameContact = @"Ho Tran Kieu Trinh";
    contact2.phoneContact = @"0123445677887";
    contact2.pathImage = @"1.jpeg";
    contact2.emailContact = @"dujksajdk@gmail.com";
    [arr addObject:contact2];
    
    //data3
    TeacherModel *contact3 = [[TeacherModel alloc]init];
    contact3.nameContact = @"Hoang Hoa Tham";
    contact3.phoneContact = @"01232398433";
    contact3.pathImage = @"2.jpg";
    contact3.emailContact = @"dujksajdk@gmail.com";
    [arr addObject:contact3];
    
    //data4
    TeacherModel *contact4 = [[TeacherModel alloc]init];
    contact4.nameContact = @"Hoa Binh";
    contact4.phoneContact = @"01232398433";
    contact4.pathImage = @"2.jpg";
    contact4.emailContact = @"dujksajdk@gmail.com";
    [arr addObject:contact4];
    
    //data5
    TeacherModel *contact5 = [[TeacherModel alloc]init];
    contact5.nameContact = @"Mot Chin Bon Nam";
    contact5.phoneContact = @"01232398433";
    contact5.pathImage = @"2.jpg";
    contact5.emailContact = @"dujksajdk@gmail.com";
    [arr addObject:contact5];
    
    //data6
    TeacherModel *contact6 = [[TeacherModel alloc]init];
    contact6.nameContact = @"Join Cenna";
    contact6.phoneContact = @"01232398433";
    contact6.pathImage = @"2.jpg";
    contact6.emailContact = @"dujksajdk@gmail.com";
    [arr addObject:contact6];
    return arr;
}


+ (NSDictionary*)createDictionary:(NSArray*)arrayWithData{
    // Sap xep tu mang arrayWithData theo nameContact
    NSArray *sortedDictionary = [[NSArray alloc] init];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"nameContact" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    sortedDictionary = [arrayWithData sortedArrayUsingDescriptors:@[sortDescriptor]].mutableCopy;
    // Dinh dang
    
    NSMutableDictionary *formatDictionary = [[NSMutableDictionary alloc] init];
    int i = 0;
    while (i < [sortedDictionary count]) {
        TeacherModel *model = [sortedDictionary objectAtIndex:i];
        NSString *key = [[model.nameContact substringToIndex:1] uppercaseString];
        NSMutableArray *childNameArray = [[NSMutableArray alloc] init];
        [childNameArray addObject:model];
        // find end
        int endInt = i + 1;
        while (endInt < [sortedDictionary count]){
            TeacherModel *model2 = [sortedDictionary objectAtIndex:endInt];
            NSString *end = [[model2.nameContact substringToIndex:1] uppercaseString];
            
            if ([end isEqualToString:key]){
                [childNameArray addObject:[sortedDictionary objectAtIndex:endInt]];
                endInt++;
            }else {
                break;
            }
        }
        [formatDictionary setObject:childNameArray forKey:key];
        i = endInt;
    }
    
    return formatDictionary;
    
}
@end
