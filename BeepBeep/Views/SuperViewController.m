//
//  SuperViewController.m
//  BeepBeep
//
//  Created by Nguyen Minh on 6/4/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import "SuperViewController.h"
#import "CDRTranslucentSideBar.h"
#import "SKSTableView.h"
#import "SKSTableViewCell.h"

@interface SuperViewController () <UIGestureRecognizerDelegate, SKSTableViewDelegate, CDRTranslucentSideBarDelegate>

@property (nonatomic, strong) NSArray *contents;
@property (nonatomic, strong) CDRTranslucentSideBar *leftSideBar;
@property (nonatomic, strong) NSString *phoneNumberHQ;
@property (nonatomic, strong) NSString *emailHQ;

@end

@implementation SuperViewController

- (NSArray *)contents {
    if (!_contents) {
        _contents = @[
                      @[
                          @[@"Current Job", @"View", @"En-Route", @"None"],
                          @[@"Job Queue", @"Map View", @"List View", @"Job"],
                          @[@"Alerts", @"Update"],
                          @[@"Contact HQ", @"Call", @"Message", @"Email"],
                          @[@"Timecard", @"Check-in", @"Check-out"]]
                      ];
    }
    
    return _contents;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.leftSideBar = [[CDRTranslucentSideBar alloc] init];
    self.leftSideBar.sideBarWidth = 250;
    self.leftSideBar.delegate = self;
    self.leftSideBar.tag = 0;
    
    // Create Content of SideBar
    SKSTableView *tableView = [[SKSTableView alloc] init];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BackgroundTableView"]];
    tableView.backgroundView = imageView;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    tableView.SKSTableViewDelegate = self;
    
    // Set ContentView in SideBar
    [self.leftSideBar setContentViewInSideBar:tableView];
    
    [self setupLefttNavigationBarItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotificationChangeTopLeftItem) name:BBNotificationToMenuItemBar object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Mark - Initiliaze navigator

- (void)setupLefttNavigationBarItem {
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"BGTextfield"] forBarMetrics:UIBarMetricsDefault];
    
    [self setPositionToTopLeftNavigatorItem:-5];
    
    UIView *titleBeepBeep = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 148, 25)];
    UIImageView *imgTitle = [[UIImageView alloc] initWithFrame:titleBeepBeep.frame];
    [imgTitle setImage:[UIImage imageNamed:@"LogoBeepBeep"]];
    [titleBeepBeep addSubview:imgTitle];
    
    self.navigationItem.titleView = titleBeepBeep;
}

- (void)setPositionToTopLeftNavigatorItem:(float)spacer {
    //    [UIView beginAnimations:nil context:NULL];
    //    [UIView setAnimationDuration:0.3];
    
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLeft setFrame:CGRectMake(0, 0, 28.0, 20.)];
    [btnLeft setImage:[UIImage imageNamed:@"menuTopLeft"] forState:UIControlStateNormal];
    [btnLeft setImage:[UIImage imageNamed:@"menuTopLeft_active"] forState:UIControlStateHighlighted];
    [btnLeft addTarget:self action:@selector(showLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = spacer;
    
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, leftBarItem, nil]];
    
    //    [UIView commitAnimations];
}

- (void)getNotificationChangeTopLeftItem {
    if (self.leftSideBar.hasShown) {
        [self setPositionToTopLeftNavigatorItem:-30];
    }
    else {
        [self setPositionToTopLeftNavigatorItem:-5];
    }
}

- (void)showLeftMenu {
    if (!self.leftSideBar.hasShown) {
        [self.leftSideBar showInViewController:self];
    }
    else {
        [self.leftSideBar dismissAnimated:YES];
    }
}

- (void)HideLeftMenu {
    if (!self.leftSideBar.hasShown) {
        [self setPositionToTopLeftNavigatorItem:-30];
        [self.leftSideBar showInViewController:self];
    }
    else {
        [self setPositionToTopLeftNavigatorItem:-5];
        [self.leftSideBar dismissAnimated:YES];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.contents count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contents[section] count];
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath {
    return [self.contents[indexPath.section][indexPath.row] count] - 1;
}

- (BOOL)tableView:(SKSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath {
    //    if (indexPath.section == 1 && indexPath.row == 0) {
    //        return YES;
    //    }
    return NO;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45.0;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SKSTableViewCell";
    
    SKSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    cell.textLabel.text = self.contents[indexPath.section][indexPath.row][0];
    cell.expandable = YES;
    
    UIFont *boldFont = [UIFont boldSystemFontOfSize:[UIFont systemFontOfSize:25.0].capHeight];
    [cell.textLabel setFont:boldFont];
    
    //    if ((indexPath.section == 0 && (indexPath.row == 1 || indexPath.row == 0)) || (indexPath.section == 1 && (indexPath.row == 0 || indexPath.row == 2)))
    //        cell.expandable = YES;
    //    else
    //        cell.expandable = NO;
    
    return cell;
}

- (UITableViewCell *)tableView:(SKSTableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.contents[indexPath.section][indexPath.row][indexPath.subRow]];
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell.contentView setBackgroundColor:BBColorToSubRowMenu];
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"Section: %ld, Row:%ld, Subrow:%ld", (long)indexPath.section, (long)indexPath.row, (long)indexPath.subRow);
//}

- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Section: %ld, Row:%ld, Subrow:%ld", (long)indexPath.section, (long)indexPath.row, (long)indexPath.subRow);
    
    if (indexPath.row == 0) {
        if (indexPath.subRow == 1) {
            //Vieww
        }
        
        if (indexPath.subRow == 2) {
            //En-Route
        }
        
        if (indexPath.subRow == 3) {
            //None
        }
    }
    
    if (indexPath.row == 1) {
        if (indexPath.subRow == 1) {
            //Map View
            [self HideLeftMenu];
            [[NSNotificationCenter defaultCenter] postNotificationName:BBNotificationShowMapView object:nil];
        }
        
        if (indexPath.subRow == 2) {
            //List View
            [self HideLeftMenu];
            [[NSNotificationCenter defaultCenter] postNotificationName:BBNotificationShowListView object:nil];
        }
        
        if (indexPath.subRow == 3) {
            //Job
        }
    }
    
    if (indexPath.row == 2) {
        if (indexPath.subRow == 1) {
            //Respond
        }
        
        if (indexPath.subRow == 2) {
            //Dismiss
        }
    }
    
    if (indexPath.row == 3) {
        switch (indexPath.subRow) {
            case 1: {
                NSURL *phoneUrl = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@", self.phoneNumberHQ]];
                
                if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
                    [[UIApplication sharedApplication] openURL:phoneUrl];
                }
                else {
                    UIAlertView *calert = [[UIAlertView alloc] initWithTitle:BBALERTConfirmation
                                                                     message:@"Call facility is not available!!!"
                                                                    delegate:nil
                                                           cancelButtonTitle:BBALERTOKButton otherButtonTitles:nil, nil];
                    [calert show];
                }
            }
                break;
                
            case 2: {
                //Send Message
                NSURL *phoneUrl = [NSURL URLWithString:[NSString stringWithFormat:@"sms:%@", self.phoneNumberHQ]];
                
                if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
                    [[UIApplication sharedApplication] openURL:phoneUrl];
                }
                else {
                    UIAlertView *calert = [[UIAlertView alloc]initWithTitle:BBALERTConfirmation
                                                                    message:@"SMS facility is not available!!!"
                                                                   delegate:nil
                                                          cancelButtonTitle:BBALERTOKButton otherButtonTitles:nil, nil];
                    [calert show];
                }
            }
                break;
                
            case 3: {
                //email
                NSURL *mailUrl = [NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@", self.emailHQ]];
                
                if ([[UIApplication sharedApplication] canOpenURL:mailUrl]) {
                    [[UIApplication sharedApplication] openURL:mailUrl];
                }
                else {
                    UIAlertView *calert = [[UIAlertView alloc]initWithTitle:BBALERTConfirmation
                                                                    message:@"Email facility is not available!!!"
                                                                   delegate:nil
                                                          cancelButtonTitle:BBALERTOKButton otherButtonTitles:nil, nil];
                    [calert show];
                }
            }
                break;
        }
    }
    
    if (indexPath.row == 4) {
        if (indexPath.subRow == 1) {
            //Check - In
        }
        
        if (indexPath.subRow == 2) {
            //Check Out
        }
    }
}

@end
