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
@interface HomeVC () <UITableViewDelegate, UITableViewDataSource, DetailVCDelegate,AddVCDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *contactArray;
@property (nonatomic,strong) NSMutableDictionary *contactDictionary;
@property (nonatomic,strong) NSArray *titleSectionArray;
@property (nonatomic,strong) NSIndexPath *myIndexPath;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
- (IBAction)didEdit:(id)sender;
- (IBAction)didClickAdd:(id)sender;
@property(nonatomic,assign) BOOL isSearch;
@property (nonatomic,assign)  NSInteger searchTextStatusLenght;
@end
@implementation HomeVC

#pragma mark - Lifecyle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBar.delegate = self;
    self.isSearch = false;
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


#pragma mark - Tableview DataSource

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
// Xoa
- (void)didClickDeleteTeacher:(TeacherModel *)model {
    NSString *key = [self.titleSectionArray objectAtIndex:self.myIndexPath.section];
    NSMutableArray *contact = [self.contactDictionary objectForKey:key];
    if ([contact count] > 1){
        [contact removeObjectAtIndex:self.myIndexPath.row];
        [self.contactDictionary setObject:contact forKey:key];
    }else{
        [self.contactDictionary removeObjectForKey:key];
    }
    [self.tableView reloadData];
}

- (IBAction)didEdit:(id)sender {
//    NSLog(@"%@",self.searchTextField.text);
    if (self.searchTextField.text != nil){
        NSString* key = [[self.searchTextField.text substringToIndex:1]uppercaseString];
        NSMutableArray *listSearch = [self.contactDictionary valueForKey:key];
        NSMutableArray *result = [[NSMutableArray alloc] init];
        for (int i = 0; i < [listSearch count]; i++){
            TeacherModel *name = [listSearch objectAtIndex:i];
            if ( [name.nameContact containsString:self.searchTextField.text]){
                [result addObject:name];
            }
        }
        self.contactDictionary = [TeacherModel createDictionary:result].mutableCopy;
        [self.tableView reloadData];
    };

}

- (IBAction)didClickAdd:(id)sender {
    AddVC *addViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Add"];
    addViewController.delegate = self;
    [self.navigationController pushViewController:addViewController animated:YES];
    
    
}
#pragma mark - Search
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length != 0){
        if (searchText.length > self.searchTextStatusLenght){
            // neu go them
            NSString* key = [[searchText substringToIndex:1]uppercaseString];
            NSMutableArray *listSearch = [self.contactDictionary valueForKey:key];
            NSMutableArray *result = [[NSMutableArray alloc] init];
            for (int i = 0; i < [listSearch count]; i++){
                TeacherModel *name = [listSearch objectAtIndex:i];
                if ( [name.nameContact containsString:searchText]){
                    [result addObject:name];
                }
            }
            self.contactDictionary = [TeacherModel createDictionary:result].mutableCopy;
            self.searchTextStatusLenght = searchText.length;
        }else{
            //  neu xoa
            self.contactDictionary = [TeacherModel createDictionary:self.contactArray].mutableCopy;
            NSString* key = [[searchText substringToIndex:1]uppercaseString];
            NSMutableArray *listSearch = [self.contactDictionary valueForKey:key];
            NSMutableArray *result = [[NSMutableArray alloc] init];
            for (int i = 0; i < [listSearch count]; i++){
                TeacherModel *name = [listSearch objectAtIndex:i];
                if ( [name.nameContact containsString:searchText]){
                    [result addObject:name];
                }
            }
            self.contactDictionary = [TeacherModel createDictionary:result].mutableCopy;
            self.searchTextStatusLenght = searchText.length;
        };
        
    }else{
        // ney rong
        self.contactDictionary = [TeacherModel createDictionary:self.contactArray].mutableCopy;
    }
    self.titleSectionArray = [[self.contactDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [self.tableView reloadData];
}
#pragma mark - Helper
//Them moi data
- (void)addNewData:(TeacherModel *)model {
    NSString *key = [[model.nameContact substringToIndex:1]uppercaseString];
//     NSMutableArray *temp = [[NSMutableArray alloc] init];
    if (![self.contactDictionary objectForKey:key]) {
        NSMutableArray *newArray = [[NSMutableArray alloc]initWithObjects:model, nil ];
        [self.contactDictionary setObject:newArray forKey:key];
    } else {
        NSMutableArray *temp = [self.contactDictionary objectForKey:key];
        [temp addObject:model];
        [self.contactDictionary setObject:temp forKey:key];
    }

    self.titleSectionArray = [[self.contactDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [self.tableView reloadData];
}
// notification
- (void)registerObservers{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didClickEdit:) name:@"didClickEdit" object:nil];
}
// call  back
- (void)didClickEdit:(NSNotification *)notification {
   // [self.navigationController popToRootViewControllerAnimated:YES];
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
