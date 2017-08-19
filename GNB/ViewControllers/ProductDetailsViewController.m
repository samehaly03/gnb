//
//  ProductDetailsViewController.m
//  GNB
//
//  Created by Macintosh HD on 8/18/17.
//  Copyright © 2017 GNB. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import "UIImageView+WebCache.h"
#import <Social/Social.h>

@interface ProductDetailsViewController ()

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *txtView;
@property (weak, nonatomic) IBOutlet UIButton *btnAddList;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;

@end

@implementation ProductDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Products";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.selectedProduct.productImage.productImageURL]
                 placeholderImage:[UIImage imageNamed:@"placeholder"]
                          options:SDWebImageRefreshCached];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // Update the UI
        [self.txtView setText:self.selectedProduct.productDescription];
        
        
        self.textViewHeightConstraint.constant = [self.txtView sizeThatFits:CGSizeMake(self.txtView.frame.size.width, CGFLOAT_MAX)].height;
        
        self.imageViewHeightConstraint.constant = [self.selectedProduct.productImage.productImageHeight doubleValue];
        
        [self.view layoutIfNeeded];
    });
    
}

- (IBAction)btnSharePressed:(UIButton *)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        
        SLComposeViewController *mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [mySLComposerSheet setInitialText:_selectedProduct.productDescription];
        
        [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            
            switch (result)
            {
                case SLComposeViewControllerResultCancelled:
                    NSLog(@"Post Canceled");
                    break;
                case SLComposeViewControllerResultDone:
                    NSLog(@"Post Sucessful");
                    break;
                    
                default:
                    break;
            }
        }];
        
        [self presentViewController:mySLComposerSheet animated:YES completion:nil];
    }
}

- (IBAction)btnAddListPressed:(UIButton *)sender {
    
    _selectedProduct.productInList = !_selectedProduct.productInList;
    
    if (_selectedProduct.productInList) {
        
        [_btnAddList setTitle:@"Remove from list" forState:UIControlStateNormal];
    }
    else
    {
        [_btnAddList setTitle:@"Add to list" forState:UIControlStateNormal];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
