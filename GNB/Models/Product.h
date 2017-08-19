//
//  Product.h
//  GNB
//
//  Created by Macintosh HD on 8/18/17.
//  Copyright © 2017 GNB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductImage.h"

@interface Product : NSObject

@property (nonatomic, strong) NSString *productID;
@property (nonatomic, strong) NSString *productDescription;
@property (nonatomic, strong) ProductImage *productImage;
@property (nonatomic, strong) NSNumber *productPrice;
@property (nonatomic) BOOL productInList;

- (instancetype)initProductWithDictionary:(NSDictionary *)dict;

@end
