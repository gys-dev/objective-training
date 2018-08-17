//
//  HomeVC.m
//  newProject
//
//  Created by TranDucY on 8/15/18.
//  Copyright © 2018 TranDucY. All rights reserved.
//
#import "HomeVC.h"
#import "TeacherModel.h"
#import "AccountCell.h"
#import "DetailsVC.h"
#import <UIKit/UIKit.h>

@interface HomeVC () <UITableViewDelegate, UITableViewDataSource, DetailVCDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *contactArray;
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Contact App";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.contactArray = [TeacherModel dummyData];
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 112;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contactArray count];
}
// duyet qua roi set data cho cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //lien ket voi TabelViewCell
    AccountCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"AccountCell"];
    
    TeacherModel *model = self.contactArray[indexPath.row];
    
    UIImage *image = [UIImage imageNamed:model.pathImage];
    [cell setupDataForCellWith:image name:model.nameContact phoneNumber:model.phoneContact];
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete:
        {
            // copy va xoa phan tu trong mang
            //[newArrayContact removeObjectAtIndex: indexPath.row];
            NSMutableArray *newArrayContact = self.contactArray.mutableCopy;
            [newArrayContact removeObjectAtIndex:indexPath.row];
            self.contactArray = newArrayContact;
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        default:
            break;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation Direction
    DetailsVC *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsVC"];
    detailVC.delegate = self;
    TeacherModel *model = self.contactArray[indexPath.row];
//    [detailVC showDetailWithTeacher:model];
    detailVC.model = model;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didClickDeleteTeacher:(TeacherModel *)model {
    // copy va xoa phan tu trong mang
    //[newArrayContact removeObjectAtIndex: indexPath.row];
    NSInteger  row;
    for (row = 0; row < [self.contactArray count]; row++){
        if (model == self.contactArray[row])
            break;
    }
    NSMutableArray *newArrayContact = self.contactArray.mutableCopy;
    [newArrayContact removeObjectAtIndex:row];
    self.contactArray = newArrayContact;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}



@end
