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
#import "SVProgressHUD.h"
@interface HomeVC () <UITableViewDelegate, UITableViewDataSource, DetailVCDelegate,AddVCDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *contactArray;
@property (nonatomic,strong) NSMutableDictionary *contactDictionary;
@property (nonatomic,strong) NSArray *titleSectionArray;
@property (nonatomic,strong) NSIndexPath *myIndexPath;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
- (IBAction)didClickAdd:(id)sender;
@property(nonatomic,assign) BOOL isSearch;
@property (nonatomic,assign)  NSInteger searchTextStatusLenght;
@property (nonatomic,assign) NSInteger runOneTimes;
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
    self.contactArray = [[NSMutableArray alloc] init];
    self.contactDictionary = [[NSMutableDictionary alloc] init];
//    self.contactArray =  [TeacherModel fetchAPI];
    [self fetchAllContacts];
//    [self setupDataWithArray:self.contactArray];
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    [self registerObservers];
   
}

- (void)dealloc
{
    [self removeObservers];
}

#pragma mark - Tableview DataSource
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
#pragma mark - gesture
// Xoa
- (void)didClickDeleteTeacher:(TeacherModel *)model {
    [self deleteRequest:model.idContact completionHandle:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error %@", error.localizedDescription);
        } else {
            [self fetchAllContacts];
        }
    }];
}

- (IBAction)didClickAdd:(id)sender {
    AddVC *addViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Add"];
    addViewController.delegate = self;
    [self.navigationController pushViewController:addViewController animated:YES];
    
    
}

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
// call  back
- (void)didClickEdit:(NSNotification *)notification {
    // [self.navigationController popToRootViewControllerAnimated:YES];
    NSMutableDictionary *re = notification.object;
    TeacherModel *moi = [re valueForKey:@"moi"];
    NSString *sendPostData = [TeacherModel jsonGenerator:moi];
    NSString *endPoint  = @"https://loicontacts.herokuapp.com/contacts/";
    endPoint = [endPoint stringByAppendingString:moi.idContact];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:endPoint]];
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody: [sendPostData dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session  = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self fetchAllContacts];
    }];
    [dataTask resume];
}
#pragma mark - Helper

- (void)setupDataWithArray:(NSArray *)array {
    self.contactDictionary = [TeacherModel createDictionary:array].mutableCopy;
    self.titleSectionArray = [[self.contactDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (void)fetchAllContacts {
    [SVProgressHUD show];
    [TeacherModel fetchAllContactsWithCompletionHandler:^(NSArray * _Nullable data, NSError * _Nullable error) {
        self.contactArray = data.mutableCopy;
        [self setupDataWithArray:self.contactArray];
        [self reloadTableView];
        [SVProgressHUD dismiss];
    }];
}

- (void)reloadTableView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)addNewData:(TeacherModel *)model {
    NSString *sendPostData = [TeacherModel jsonGenerator:model];
    NSString *endPoint  = @"https://loicontacts.herokuapp.com/contacts/";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:endPoint]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody: [sendPostData dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session  = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil)
            [self fetchAllContacts];
    }];
    [dataTask resume];
    
}
// notification
- (void)registerObservers{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didClickEdit:) name:@"didClickEdit" object:nil];
}

- (void)deleteRequest:(NSString *)idContact completionHandle:(void(^_Nullable)(NSData * _Nullable data, NSError *_Nullable error))completionHandle{
    NSString *endPoint  = @"https://loicontacts.herokuapp.com/contacts/";
    endPoint = [endPoint stringByAppendingString:idContact];
    NSMutableURLRequest *request  = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:endPoint]];
    [request setHTTPMethod:@"DELETE"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error == nil){
                completionHandle(nil, error);
                return;
            }else{
                [self fetchAllContacts];
                completionHandle(data, nil);
                return;
            };
        });
    }];
    [dataTask resume];
}

// remove noti
- (void)removeObservers{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
