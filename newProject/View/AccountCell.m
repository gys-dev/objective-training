//
//  AccountCell.m
//  newProject
//
//  Created by TranDucY on 8/15/18.
//  Copyright © 2018 TranDucY. All rights reserved.
//

#import "AccountCell.h"

@interface AccountCell ()

@property (weak, nonatomic) IBOutlet UIImageView *accountImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameAccountLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;

@end

@implementation AccountCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setupDataForCellWith:(UIImage *)accountImage name:(NSString *)name phoneNumber:(NSString *)phoneNumber {
    self.nameAccountLabel.text = name;
    self.phoneNumberLabel.text = phoneNumber;
    self.accountImageView.image = accountImage;
}

@end
