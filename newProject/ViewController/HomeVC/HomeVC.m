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
#import "AddVC.h"
#import "EditVC.h"
@interface HomeVC () <UITableViewDelegate, UITableViewDataSource, DetailVCDelegate,AddVCDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *contactArray;
@property (nonatomic,strong) NSMutableDictionary *contactDictionary;
@property (nonatomic,strong) NSArray *titleSectionArray;
@property (nonatomic,strong) NSIndexPath *myIndexPath;
- (IBAction)didClickAdd:(id)sender;


@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Contact App";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
     // data
    self.contactArray = [TeacherModel dummyData];
    self.contactDictionary = [TeacherModel createDictionary:self.contactArray].mutableCopy;
    self.titleSectionArray = [[self.contactDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
    
    //call notification
    [self registerObservers];
//    EditVC *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"EditVC"];
//    edit.delegate = self;
}

- (void)dealloc
{
    [self removeObservers];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.contactDictionary count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionTitle = [self.titleSectionArray objectAtIndex:section];
    NSArray *contactOfRow = [self.contactDictionary objectForKey:sectionTitle];
    return [contactOfRow count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 112;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.titleSectionArray objectAtIndex:section];
}


// duyet qua roi set data cho cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //lien ket voi TabelViewCell
    AccountCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"AccountCell"];
    NSString *sectionTitle = [self.titleSectionArray objectAtIndex:indexPath.section];
    NSArray *sectionContact = [self.contactDictionary objectForKey:sectionTitle];
    TeacherModel *model = [sectionContact objectAtIndex:indexPath.row];
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
            NSString *key = [self.titleSectionArray objectAtIndex:indexPath.section];
            NSMutableArray *contact = [self.contactDictionary objectForKey:key];
            [contact removeObjectAtIndex:indexPath.row];
            [self.contactDictionary setObject:contact forKey:key];
            [self.tableView reloadData];
//            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
    NSString *key = [[self.titleSectionArray objectAtIndex:indexPath.section] uppercaseString];
    NSArray *arr = [self.contactDictionary valueForKey:key];
    TeacherModel *model = arr[indexPath.row];
    [detailVC showDetailWithTeacher:model];
    detailVC.model = model;
    self.myIndexPath = indexPath;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didClickDeleteTeacher:(TeacherModel *)model {
    NSString *key = [self.titleSectionArray objectAtIndex:self.myIndexPath.section];
    NSMutableArray *contact = [self.contactDictionary objectForKey:key];
    [contact removeObjectAtIndex:self.myIndexPath.row];
    [self.contactDictionary setObject:contact forKey:key];
    [self.tableView reloadData];
}

- (IBAction)didClickAdd:(id)sender {
    AddVC *addViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Add"];
    addViewController.delegate = self;
    [self.navigationController pushViewController:addViewController animated:YES];
    
    
}
//Them moi data
- (void)addNewData:(TeacherModel *)model {
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSString *key = [[model.nameContact substringToIndex:1]uppercaseString];
    NSMutableArray *temp = [self.contactDictionary objectForKey:key];
    if (temp == nil){
        // add new
        NSArray *newArray = [[NSArray alloc]initWithObjects:model, nil ];
        [self.contactDictionary setObject:newArray forKey:key];
    }else {
        // find and replace
        [temp addObject:model];
        [self.contactDictionary setObject:temp forKey:key];
    };
    // update title
    self.titleSectionArray = [[self.contactDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [self.tableView reloadData];
}
// notification
- (void)registerObservers{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didClickEdit:) name:@"didClickEdit" object:nil];
}
// call  back
- (void)didClickEdit:(NSNotification *)notification {
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSMutableDictionary *re = notification.object;
    TeacherModel *cu = [re valueForKey:@"cu"];
    TeacherModel *moi = [re valueForKey:@"moi"];
    
    NSString *key = [[cu.nameContact substringToIndex:1] uppercaseString];
    NSMutableArray *arr = [self.contactDictionary valueForKey:key];
    if (arr == nil){
        [self.contactDictionary setObject:arr forKey:key];
    }else{
        int pos;
        for (pos = 0; pos < [arr count]; pos++){
            if (cu == [arr objectAtIndex:pos])
                break;
        };
        [arr setObject:moi atIndexedSubscript:pos];
        [self.contactDictionary setObject:arr forKey:key];
    }
    [self.tableView reloadData];
}
// remove noti
- (void)removeObservers{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
