//
//  ProductCell.h
//  GNB
//
//  Created by Macintosh HD on 8/18/17.
//  Copyright © 2017 GNB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ProductCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UITextView *txtDescription;
@property (nonatomic, weak) IBOutlet UILabel *lblPrice;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *txtViewHeight;
@property (nonatomic, weak) IBOutlet UIButton *btnAddList;

@end
