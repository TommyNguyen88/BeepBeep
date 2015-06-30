//
//  ListViewController.m
//  BeepBeep
//
//  Created by Nguyen Minh on 6/12/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import "ListViewController.h"
#import "ListCollectionViewCell.h"
#import "PSTCollectionView.h"

#define ITEMS_PAGE_SIZE 4
#define ITEM_CELL_IDENTIFIER @"ItemCell"
#define LOADING_CELL_IDENTIFIER @"LoadingItemCell"

@interface ListViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *dataItems;
    NSDate *currentDate;
    UIRefreshControl *refresher;
    UIRefreshControl *bottomRefresher;
}

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UICollectionViewFlowLayout *listViewLayout;
@property (strong, nonatomic) IBOutlet UIView *viewDateTime;
@property (weak, nonatomic) IBOutlet UILabel *lbDateTime;
@property (weak, nonatomic) IBOutlet UIDatePicker *pickerDate;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (!dataItems) {
        dataItems = [[NSMutableArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", nil];
    }
    
    currentDate = [NSDate date];
    
    _viewDateTime.frame = CGRectMake(0, 2500, DEVICE_WIDTH, _viewDateTime.frame.size.height);
    [self.view addSubview:_viewDateTime];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ListCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ListCell"];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:LOADING_CELL_IDENTIFIER];
    
    self.listViewLayout = [[UICollectionViewFlowLayout alloc] init];
    self.listViewLayout.scrollDirection = PSTCollectionViewScrollDirectionVertical;
    
    self.listViewLayout.itemSize = CGSizeMake(300, 132);
    
    if (IS_STANDARD_IPHONE_6) {
        self.listViewLayout.itemSize = CGSizeMake(350, 132);
    }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        self.listViewLayout.itemSize = CGSizeMake(400, 132);
    }
    
    self.listViewLayout.minimumLineSpacing = 5.0f;
    self.listViewLayout.sectionInset = UIEdgeInsetsMake(5.0f, 2.0f, 0.0f, 5.0f);
    [self.collectionView setCollectionViewLayout:self.listViewLayout animated:NO];
    
    if (!refresher) {
        refresher = UIRefreshControl.new;
        [refresher addTarget:self
                      action:@selector(startRefreshTogetMoreItems)
            forControlEvents:UIControlEventValueChanged];
        [self.collectionView addSubview:refresher];
        self.collectionView.alwaysBounceVertical = YES;
    }
    
    if (!bottomRefresher) {
        bottomRefresher = UIRefreshControl.new;
        [bottomRefresher addTarget:self
                            action:@selector(fetchMoreItems)
                  forControlEvents:UIControlEventValueChanged];
        
        self.collectionView.bottomRefreshControl = bottomRefresher;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Mark -

#pragma Mark - CollectionView DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return dataItems.count;
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ListCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[ListCollectionViewCell alloc] init];
    }
    
    int number = (int)indexPath.row;
    
    [cell.lbNumber setText:[NSString stringWithFormat:@"#(%@)", [dataItems objectAtIndex:indexPath.row]]];
    
    if (number % 2 == 0) {
        [cell setBackgroundColor:Rgb2UIColor(245.0, 246.0, 249.0)];
    }
    if (dataItems.count > indexPath.row) {
        //
    }
    else {
        //
    }
    
    return cell;
}

#pragma Mark - Load more action

- (void)startRefreshTogetMoreItems {
    [self performSelector:@selector(endRefreshingAfterCheckNoNetwork) withObject:nil afterDelay:0.5];
}

- (void)fetchMoreItems {
    NSLog(@"FETCHING MORE ITEMS FROM LOCAL ******************");
    [self performSelector:@selector(endRefreshingAfterCheckNoNetwork) withObject:nil afterDelay:0.5];
}

- (void)endRefreshingAfterCheckNoNetwork {
    if (refresher.isRefreshing) {
        [refresher endRefreshing];
    }
    if (bottomRefresher.isRefreshing) {
        [bottomRefresher endRefreshing];
    }
}

- (void)setupRightNavigationBarItem {
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"BGTextfield"] forBarMetrics:UIBarMetricsDefault];
    
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRight setFrame:CGRectMake(0, 0, 28.0, 20.)];
    [btnRight setImage:[UIImage imageNamed:@"menuTopLeft"] forState:UIControlStateNormal];
    [btnRight setImage:[UIImage imageNamed:@"menuTopLeft_active"] forState:UIControlStateHighlighted];
    [btnRight addTarget:self action:@selector(actionShowPickerDate:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = 0;
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, rightBarItem, nil]];
}

#pragma Mark - Picker Date Time

- (IBAction)actionShowPickerDate:(id)sender {
    [self.view endEditing:YES];
    self.pickerDate.date = [[NSDate date] dateByAddingTimeInterval:1800];
    
    [self setOriginYToPickerDate:(self.view.frame.size.height - _viewDateTime.frame.size.height)];
}

- (IBAction)cancelPickerDate:(id)sender {
    [self setOriginYToPickerDate:2500];
}

- (IBAction)donePickerDate:(id)sender {
    NSDate *chosen = [self.pickerDate date];
    
    currentDate = chosen;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE' 'MMMM' 'dd', 'yyyy"];
    NSString *yourDate = [dateFormatter stringFromDate:chosen];
    
    [self.lbDateTime setText:yourDate];
    [self setOriginYToPickerDate:2500];
}

- (void)setOriginYToPickerDate:(float)originY {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    _viewDateTime.frame = CGRectMake(0, originY, _viewDateTime.frame.size.width, _viewDateTime.frame.size.height);
    
    [UIView commitAnimations];
}

@end
