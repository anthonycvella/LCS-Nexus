//
//  ScheduleTableViewController.m
//  LCS Nexus
//
//  Created by Vella, Anthony on 7/8/14.
//  Copyright (c) 2014 Vella, Anthony. All rights reserved.
//

#import "ScheduleViewController.h"
#import "ScheduleCellView.h"
#import "ScheduleModel.h"
#import "HMSegmentedControl.h"
#import <AFNetworking/AFNetworking.h>

@interface ScheduleViewController()

@property (strong, nonatomic) ScheduleModel *scheduleModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *segmentedView;
@property (strong, nonatomic) HMSegmentedControl *segmentedControl;

@end

@implementation ScheduleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Week 1", @"Week 2", @"Week 3", @"Week 4", @"Week 5", @"Week 6", @"Week 7", @"Week 8"]];
    self.segmentedControl.frame = CGRectMake(0, 0, self.segmentedView.frame.size.width, self.segmentedView.frame.size.height);
    self.segmentedControl.textColor = [UIColor colorWithRed:196.0/255.0 green:146.0/255.0 blue:70.0/255.0 alpha:1];
    self.segmentedControl.selectedTextColor = [UIColor whiteColor];
    self.segmentedControl.backgroundColor = [UIColor colorWithRed:29.0/255.0 green:29.0/255.0 blue:29.0/255.0 alpha:1];
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    self.segmentedControl.selectionIndicatorColor = [UIColor whiteColor];
    self.segmentedControl.selectionIndicatorHeight = 2.0f;
    self.segmentedControl.scrollEnabled = YES;
    [self.segmentedControl setSegmentEdgeInset:UIEdgeInsetsMake(0, 20, 0, 20)];
    [self.segmentedView addSubview:self.segmentedControl];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(matchDataLoaded) name:@"MatchDataLoaded" object:nil];
    
    self.scheduleModel = [[ScheduleModel alloc] init];
    [self.scheduleModel loadDataFromJSON];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //self.segmentedControl.frame = self.segmentedControl.bounds;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)matchDataLoaded
{
    NSLog(@"%@", self.scheduleModel.sortedKeys);
//    self.segmentedControl.sectionTitles = self.scheduleModel.sortedKeys;
    self.segmentedControl.frame = CGRectMake(0, 0, self.segmentedView.frame.size.width, self.segmentedView.frame.size.height);

    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.scheduleModel.sortedKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ScheduleCell";
    ScheduleCellView *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    [cell setCellContent:[self.scheduleModel matchForIndex:indexPath.row]];
    
    return cell;
}

@end