//
//  FeaturedImageView.m
//  GNB
//
//  Created by Macintosh HD on 8/19/17.
//  Copyright © 2017 GNB. All rights reserved.
//

#import "FeaturedImageView.h"
#import <QuartzCore/QuartzCore.h>

@implementation FeaturedImageView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.layer.cornerRadius = self.frame.size.height / 12;
        self.clipsToBounds = YES;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 2.0f;
        self.layer.backgroundColor = [UIColor blackColor].CGColor;
    
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code

}
 */

@end
