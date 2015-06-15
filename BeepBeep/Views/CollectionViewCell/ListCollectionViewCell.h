//
//  ListCollectionViewCell.h
//  BeepBeep
//
//  Created by Nguyen Minh on 6/5/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbNumber;
@property (weak, nonatomic) IBOutlet UILabel *lbLocationName;
@property (weak, nonatomic) IBOutlet UILabel *lbLocationAddress;
@property (weak, nonatomic) IBOutlet UILabel *lbLocationTime;
@property (weak, nonatomic) IBOutlet UILabel *lbLocationCity;

@end
