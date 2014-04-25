//
//  ViewController.m
//  TableIndexDemo
//
//  Created by Xummer on 14-4-25.
//  Copyright (c) 2014年 Xummer. All rights reserved.
//

#import "ViewController.h"
#import "ContactCell.h"

static NSString *contactsCellIdentifier = @"contactsCell";

@interface ViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate
>
{
    NSUInteger _lastContactsHash;
}
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *contacts;
@property (strong, nonatomic) NSArray *indexList;

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupSubviews];
    [self updateContent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateContent {
    NSArray *data = @[
                      @"ACFun",
                      @"Bilibili",
                      @"Niconico",
                      @"BlaBla",
                      @"Test",
                      @"Adobe",
                      @"Heyheyhey",
                      @"Demmy",
                      @"Well",
                      @"Stephen Jobs",
                      @"Stephen Woz",
                      @"中文",
                      @"あなた",
                      @"***",
                      @"@",
                      @"((((",
                      @"中ENあ"
                      ];
    NSMutableArray *tmpArr = [NSMutableArray array];
    
    for (NSString *name in data) {
        ContactEntity *contact = [[ContactEntity alloc] init];
        contact.name = name;
        contact.avatarUrl = @"78268";
        contact.detail = @"2333";
        [tmpArr addObject:contact];
    }
    
    self.contacts = tmpArr;
    
}

- (void)setContacts:(NSArray *)objects {
    
    if (objects.hash == _lastContactsHash) {
        return;
    }
    
    _lastContactsHash = objects.hash;
    
    _contacts = [self arrayForSections:objects];
    [_tableView reloadData];
}

- (NSArray *)arrayForSections:(NSArray *)objects {
    SEL selector = @selector(name);
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    // sectionTitlesCount 27 , A - Z + #
    NSInteger sectionTitlesCount = [[collation sectionTitles] count];
    
    // Create 27 sections' data
    NSMutableArray *mutableSections = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
    for (NSUInteger idx = 0; idx < sectionTitlesCount; idx++) {
        [mutableSections addObject:[NSMutableArray array]];
    }
    
    // Insert records
    for (id object in objects) {
        NSInteger sectionNumber = [collation sectionForObject:object collationStringSelector:selector];
        [[mutableSections objectAtIndex:sectionNumber] addObject:object];
    }
    
    for (NSUInteger idx = 0; idx < sectionTitlesCount; idx++) {
        NSArray *objectsForSection = [mutableSections objectAtIndex:idx];
        [mutableSections replaceObjectAtIndex:idx withObject:[[UILocalizedIndexedCollation currentCollation] sortedArrayFromArray:objectsForSection collationStringSelector:selector]];
    }
    
    // Remove empty sections
    NSMutableArray *existTitleSections = [NSMutableArray array];
    
    for (NSArray *section in mutableSections) {
        if ([section count] > 0) {
            [existTitleSections addObject:section];
        }
    }
    
    // Remove empty sections Index in |indexList|
    
    NSMutableArray *existTitles = [NSMutableArray array];
    NSArray *allSections = [collation sectionIndexTitles];
    
    for (NSUInteger i = 0; i < [allSections count]; i++) {
        if ([mutableSections[ i ] count] > 0) {
            [existTitles addObject:allSections[ i ]];
        }
    }
    self.indexList = existTitles;
    
    return existTitleSections;
}

- (void)setupSubviews {
    
    // Header
    self.title = @"Contacts";
    
    // setup tableview
    
    CGRect frame = self.view.bounds;
    
    self.tableView =
    [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [_tableView registerClass:[ContactCell class]
       forCellReuseIdentifier:contactsCellIdentifier];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    
    
}

- (void)addAction:(id)sender {
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_contacts count];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [_contacts[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactCell *cell =
    [tableView dequeueReusableCellWithIdentifier:contactsCellIdentifier
                                    forIndexPath:indexPath];
    [cell updateContent:_contacts[ indexPath.section ][ indexPath.row ]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    return _indexList[ section ];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _indexList;
}

- (NSInteger)tableView:(UITableView *)tableView
sectionForSectionIndexTitle:(NSString *)title
               atIndex:(NSInteger)index
{
    return index;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
