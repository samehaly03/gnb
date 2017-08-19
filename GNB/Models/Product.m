//
//  Product.m
//  GNB
//
//  Created by Macintosh HD on 8/18/17.
//  Copyright © 2017 GNB. All rights reserved.
//

#import "Product.h"

@implementation Product

- (instancetype)initProductWithDictionary:(NSDictionary *)dict
{
    if (self)
    {
        if (![[dict objectForKey:@"id"] isKindOfClass:[NSNull class]]) { self.productID = [dict objectForKey:@"id"];}
        
        if (![[dict objectForKey:@"productDescription"] isKindOfClass:[NSNull class]]) { self.productDescription = [dict objectForKey:@"productDescription"];}
        
        if (![[dict objectForKey:@"image"] isKindOfClass:[NSNull class]]) { self.productImage = [[ProductImage alloc] initProductImageWithDictionary:[dict objectForKey:@"image"]];}
        
        if (![[dict objectForKey:@"price"] isKindOfClass:[NSNull class]]) { self.productPrice = [dict objectForKey:@"price"];}
        
        self.productInList = NO;
        
        
    }
    return self;
}

@end
