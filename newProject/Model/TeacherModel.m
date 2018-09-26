
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
#pragma mark - Init Model
- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    self.nameContact = [[dict objectForKey:@"firstName"] stringByAppendingString:@" "];
    self.nameContact = [self.nameContact stringByAppendingString:[dict objectForKey:@"lastName"]];
    self.phoneContact = [[dict objectForKey:@"phone"] valueForKey:@"mobile"];
    self.emailContact = [dict objectForKey:@"email"];
    self.pathImage = [dict objectForKey:@"twitter"];
    self.idContact = [dict objectForKey:@"_id"];
    self.pathImage = [dict objectForKey:@"twitter"];
    return self;
}
//http://m.mfun.vn/uploads/huong/13445460_1037889249624616_2350317967011431053_n.jpg
#pragma mark - Data Source
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
+ (NSMutableArray *)fetchAPI{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSError *error;
    NSString *url_string = [NSString stringWithFormat: @"https://loicontacts.herokuapp.com/contacts"];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    for (NSDictionary *item in json){
        TeacherModel *fetchData = [[TeacherModel alloc] init];
        fetchData.nameContact = [[item objectForKey:@"firstName"] stringByAppendingString:@" "];
        fetchData.nameContact = [fetchData.nameContact stringByAppendingString:[item objectForKey:@"lastName"]];
        fetchData.phoneContact = [[item objectForKey:@"phone"] objectForKey:@"mobile"];
        fetchData.emailContact = [item objectForKey:@"email"];
        fetchData.pathImage = [item objectForKey:@"twitter"];
        fetchData.idContact = [item objectForKey:@"_id"];
        [result addObject:fetchData];
    };
    return result;
}

//
+(void)fetchAllContactsWithCompletionHandler:(void(^_Nullable)(NSArray * _Nullable data,NSError *_Nullable error))completionHandle{
//    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:@""]
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask=[session dataTaskWithURL:[NSURL URLWithString:@"https://loicontacts.herokuapp.com/contacts"]completionHandler:^(NSData* _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                {
                    dispatch_async(dispatch_get_main_queue(),^{
                        if (error!=nil) {
                            completionHandle(nil,error);
                            return;
                        }
                        NSError *errorParse=nil;
                        NSArray *jsonResults=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&errorParse];
                        if (errorParse) {
                            //                           NSLog(@"Can’t parse json");
                        }
                        else{
                            
                            NSMutableArray *placeModels = [[NSMutableArray alloc]init];
                            for (NSDictionary *item in jsonResults){
                                TeacherModel * fetchData= [[TeacherModel alloc] initWithDictionary:item];
                                fetchData.pathImage = @"http://m.mfun.vn/uploads/huong/13445460_1037889249624616_2350317967011431053_n.jpg";
                                [placeModels addObject:fetchData];
                            };
                            completionHandle(placeModels,nil);
                            
                        }
                    });
                }];
    [dataTask resume];

};
#pragma mark - Helper
+ (NSMutableDictionary*)createDictionary:(NSMutableArray*)arrayWithData{
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

+ (NSString *)jsonGenerator:(TeacherModel *)model{
    NSString *firstName = [[model.nameContact componentsSeparatedByString:@" "] objectAtIndex:0];
//    NSString *lastName = [[model.nameContact componentsSeparatedByString:@" "] objectAtIndex:1];
    NSRange range = [model.nameContact rangeOfString:firstName];
    NSString *lastName = [model.nameContact substringFromIndex:(range.location + range.length + 1)];
    NSMutableDictionary *phoneDict = [[NSMutableDictionary alloc] init];
    [phoneDict setValue:model.phoneContact forKey:@"mobile"];
    [phoneDict setValue:@"" forKey:@"work"];
    NSMutableDictionary *newDictionary = [[NSMutableDictionary alloc] init];
    [newDictionary setObject:firstName forKey:@"firstName"];
    [newDictionary setObject:lastName forKey:@"lastName"];
    [newDictionary setObject:model.emailContact forKey:@"email"];
    [newDictionary setObject:phoneDict forKey:@"phone"];
    NSError *error;
    NSData *dataJsonString = [NSJSONSerialization dataWithJSONObject:newDictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *result = [[NSString alloc] initWithData:dataJsonString encoding:NSUTF8StringEncoding];
    NSLog(@"%@",result);
    return result;
}
@end
