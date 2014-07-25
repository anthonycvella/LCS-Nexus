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
    
    // Add a bottomBorder.
    CALayer *bottomBorder = [CALayer layer];
    
    bottomBorder.frame = CGRectMake(0.0f, 43.0f, self.view.frame.size.width, 1.0f);
    
    bottomBorder.backgroundColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1].CGColor;
    
    [self.view.layer addSublayer:bottomBorder];
    
    self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Week 1", @"Week 2", @"Week 3", @"Week 4", @"Week 5", @"Week 6", @"Week 7", @"Week 8"]];
    self.segmentedControl.frame = CGRectMake(0, 0, self.segmentedView.frame.size.width, self.segmentedView.frame.size.height);
    self.segmentedControl.textColor = [UIColor colorWithRed:196.0/255.0 green:146.0/255.0 blue:70.0/255.0 alpha:1];
    self.segmentedControl.selectedTextColor = [UIColor whiteColor];
    self.segmentedControl.font = [UIFont fontWithName:@"HelveticaNeue" size:17.0f];
    self.segmentedControl.backgroundColor = [UIColor colorWithRed:31.0/255.0 green:31.0/255.0 blue:31.0/255.0 alpha:1];
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    self.segmentedControl.selectionIndicatorColor = [UIColor whiteColor];
    self.segmentedControl.selectionIndicatorHeight = 4.0f;
    self.segmentedControl.scrollEnabled = YES;
    [self.segmentedControl setSegmentEdgeInset:UIEdgeInsetsMake(0, 20, 0, 20)];
    [self.segmentedControl addTarget:self action:@selector(newRoundSelected:) forControlEvents:UIControlEventValueChanged];
    [self.segmentedView addSubview:self.segmentedControl];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scheduleDataLoaded) name:@"ScheduleDataLoaded" object:nil];
    
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)scheduleDataLoaded
{
    NSLog(@"%@", self.scheduleModel.sortedKeys);
    self.segmentedControl.sectionTitles = self.scheduleModel.sectionTitles;
    self.segmentedControl.frame = CGRectMake(0, 0, self.segmentedView.frame.size.width, self.segmentedView.frame.size.height);

    [self.tableView reloadData];
}

- (void)newRoundSelected:(HMSegmentedControl *)segmentedControl
{
    //[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    //[self.tableView setContentOffset:CGPointZero animated:YES];
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    int selectedRound = (int)self.segmentedControl.selectedSegmentIndex;
    
    if (self.scheduleModel.sortedKeys && self.scheduleModel.sortedKeys.count > selectedRound)
    {
        NSString *round = [[self.scheduleModel sortedKeys] objectAtIndex:selectedRound];
        return [self.scheduleModel numberOfDaysForRound:round];
    } else {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    int selectedRound = (int)self.segmentedControl.selectedSegmentIndex;
    
    if (self.scheduleModel.sortedKeys && self.scheduleModel.sortedKeys.count > selectedRound) {
        NSString *round = self.scheduleModel.sortedKeys[self.segmentedControl.selectedSegmentIndex];
        return [self.scheduleModel numberOfMatchesForRound:round ForDayIndex:(int)section];
    } else {
        return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    int selectedRound = (int)self.segmentedControl.selectedSegmentIndex;
    
    if (self.scheduleModel.sortedKeys && self.scheduleModel.sortedKeys.count > selectedRound) {
        NSString *round = self.scheduleModel.sortedKeys[self.segmentedControl.selectedSegmentIndex];
        return [self.scheduleModel dayNameForRound:round forDayIndex:(int)section];
    } else {
        return @"";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ScheduleCell";
    ScheduleCellView *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    int selectedRound = (int)self.segmentedControl.selectedSegmentIndex;
    NSString *round = self.scheduleModel.sortedKeys[selectedRound];
    MatchModel *match = [self.scheduleModel matchForRound:round forDay:(int)indexPath.section forIndexRow:(int)indexPath.row];
    [cell setCellContent:match];
    
    return cell;
}

@end
