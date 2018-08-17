//
//  AccountCell.h
//  newProject
//
//  Created by TranDucY on 8/15/18.
//  Copyright © 2018 TranDucY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountCell : UITableViewCell

- (void)setupDataForCellWith:(UIImage *)accountImage name:(NSString *)name phoneNumber:(NSString *)phoneNumber;

@end
