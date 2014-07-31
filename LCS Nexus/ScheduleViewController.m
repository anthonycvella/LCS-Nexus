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
#import "MatchViewController.h"

@interface ScheduleViewController()

@property (strong, nonatomic) ScheduleModel *scheduleModel;
@property (strong, nonatomic) MatchModel *matchModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *segmentedView;
@property (strong, nonatomic) HMSegmentedControl *segmentedControl;
@property (strong, nonatomic) UIImageView *navBarHairlineImageView;

@end

@implementation ScheduleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navBarHairlineImageView = [self hideLineUnderNavigationBar:self.navigationController.navigationBar];
    
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
    self.navBarHairlineImageView.hidden = YES;
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    int selectedRound = (int)self.segmentedControl.selectedSegmentIndex;
    NSString *title;
    
    if (self.scheduleModel.sortedKeys && self.scheduleModel.sortedKeys.count > selectedRound) {
        NSString *round = self.scheduleModel.sortedKeys[self.segmentedControl.selectedSegmentIndex];
        title = [self.scheduleModel dayNameForRound:round forDayIndex:(int)section];
    } else {
        title = @"";
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    view.backgroundColor = [UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:1.0];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width, 30)];
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0];
    label.textColor = [UIColor lightGrayColor];
    label.text = title;
    
    [view addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    int selectedRound = (int)self.segmentedControl.selectedSegmentIndex;
    
    if (self.scheduleModel.sortedKeys && self.scheduleModel.sortedKeys.count > selectedRound) {
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ScheduleCell";
    ScheduleCellView *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.contentView.bounds];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1.0];

    int selectedRound = (int)self.segmentedControl.selectedSegmentIndex;
    NSString *round = self.scheduleModel.sortedKeys[selectedRound];
    self.matchModel = [self.scheduleModel matchForRound:round forDay:(int)indexPath.section forIndexRow:(int)indexPath.row];
    [cell setCellContent:self.matchModel];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MatchViewController"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        int selectedRound = (int)self.segmentedControl.selectedSegmentIndex;
        NSString *round = self.scheduleModel.sortedKeys[selectedRound];
        self.matchModel = [self.scheduleModel matchForRound:round forDay:(int)indexPath.section forIndexRow:(int)indexPath.row];
        MatchViewController *matchViewController = [segue destinationViewController];
        matchViewController.matchModel = self.matchModel;
        matchViewController.gameId = self.matchModel.gameId;
    }
}

- (UIImageView *)hideLineUnderNavigationBar:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self hideLineUnderNavigationBar:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

@end
