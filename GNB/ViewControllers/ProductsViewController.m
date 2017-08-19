//
//  ViewController.m
//  GNB
//
//  Created by Macintosh HD on 8/18/17.
//  Copyright © 2017 GNB. All rights reserved.
//

#import "ProductsViewController.h"
#import "ProductsWebService.h"
#import "Product.h"
#import "UIImageView+WebCache.h"
#import "ProductCell.h"
#import "FeaturedImageView.h"
#import "ProductDetailsViewController.h"

@interface ProductsViewController ()
{
    ProductsWebService *productsWebService;
    NSMutableArray *productsArray;
    
}

@property (nonatomic, strong) Product *selectedProduct;
@property (nonatomic, weak) IBOutlet UICollectionView *allProductsView;
@property (nonatomic, weak) IBOutlet UIScrollView *featuredScrollView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *actView;

@end

@implementation ProductsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Products";
    
    productsWebService = [[ProductsWebService alloc] init];
    productsArray = [NSMutableArray array];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self getProducts];
}

- (void)getProducts
{
    [productsWebService getProductsFrom:(int)productsArray.count max:20 WithSuccess:^(NSMutableArray *data) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            //reload collectionview
            [self.actView stopAnimating];
            
            [productsArray addObjectsFromArray:data];
            
            [self.allProductsView reloadData];
            
            [self setupFeaturedView];
            
            
        });
        
    } failure:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.actView stopAnimating];
            
            //display alert
            
        });
    }];
}

- (void)setupFeaturedView
{
    float marginV = self.featuredScrollView.frame.size.height * 0.05;
    float marginH = self.featuredScrollView.frame.size.height * 0.05;
    
    float height = self.featuredScrollView.frame.size.height - (marginV * 2);
    
    float itemWidth = self.featuredScrollView.frame.size.width/5;
    
    for (int i = 0; i < 8; i++)
    {
        
        CGFloat xOrigin = (i * itemWidth) + (marginH * i) + marginH ;
        
        FeaturedImageView *imageView = [[FeaturedImageView alloc] initWithFrame:CGRectMake(xOrigin, marginV, itemWidth, height)];
        
        
        imageView.userInteractionEnabled = YES;
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        imageView.tag = i;
        
        UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapImageGesture:)];
        
        tapGesture1.numberOfTapsRequired = 1;
        
        [tapGesture1 setDelegate:self];
        
        [imageView addGestureRecognizer:tapGesture1];
        
        [self.featuredScrollView addSubview:imageView];
        
        Product *product = [productsArray objectAtIndex:i];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:product.productImage.productImageURL]
                          placeholderImage:[UIImage imageNamed:@"placeholder"]
                                   options:SDWebImageRefreshCached];
        
    }
    
    self.featuredScrollView.contentSize = CGSizeMake((8 * itemWidth) + 8 * marginH + marginH, self.featuredScrollView.frame.size.height);

}

- (void)btnAddListPressed:(UIButton *)sender
{
    Product *product = [productsArray objectAtIndex:sender.tag];
    
    product.productInList = !product.productInList;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    
    [self.allProductsView reloadItemsAtIndexPaths:@[indexPath]];
    
    
}

#pragma mark- UIGestureRecognizer
- (void)tapImageGesture:(UITapGestureRecognizer *)sender
{
    
    UIImageView *whichImage = (UIImageView *)[sender view];
    
        
    _selectedProduct = [productsArray objectAtIndex:whichImage.tag];

    [self performSegueWithIdentifier:@"toDetails" sender:self];
    
}


#pragma mark- UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return productsArray.count;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductImage *image =  ((Product *)[productsArray objectAtIndex:indexPath.row]).productImage;

    return CGSizeMake(collectionView.frame.size.width, [image.productImageHeight floatValue]);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PRODUCTCELL" forIndexPath:indexPath];
    
    Product *product = [productsArray objectAtIndex:indexPath.row];
    
    [cell.lblPrice setText:[NSString stringWithFormat:@"%@ EGP", [product.productPrice stringValue]]];
    
    [cell.txtDescription setText:product.productDescription];
    
    cell.btnAddList.tag = indexPath.row;
    
    if (product.productInList) {
        
        [cell.btnAddList setTitle:@"Remove from list" forState:UIControlStateNormal];
    }
    else
    {
        [cell.btnAddList setTitle:@"Add to list" forState:UIControlStateNormal];
    }
    
    [cell.btnAddList addTarget:self action:@selector(btnAddListPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        cell.txtViewHeight.constant = [cell.txtDescription sizeThatFits:CGSizeMake(cell.txtDescription.frame.size.width, CGFLOAT_MAX)].height;

        
        [self.view layoutIfNeeded];
    });
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:product.productImage.productImageURL]
                 placeholderImage:[UIImage imageNamed:@"placeholder"]
                          options:SDWebImageRefreshCached];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [productsArray count] - 5 )
    {
        [self getProducts];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedProduct = [productsArray objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"toDetails" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    ProductDetailsViewController *vc = (ProductDetailsViewController *)[segue destinationViewController];
    vc.selectedProduct = self.selectedProduct;
    
}

@end
