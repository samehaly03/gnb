//
//  ProductImage.m
//  GNB
//
//  Created by Macintosh HD on 8/18/17.
//  Copyright © 2017 GNB. All rights reserved.
//

#import "ProductImage.h"

@implementation ProductImage

- (instancetype)initProductImageWithDictionary:(NSDictionary *)dict
{
    if (self)
    {
        if (![[dict objectForKey:@"width"] isKindOfClass:[NSNull class]]) { self.productImageWidth = [dict objectForKey:@"width"]; }
        
        if (![[dict objectForKey:@"height"] isKindOfClass:[NSNull class]]) { self.productImageHeight = [dict objectForKey:@"height"]; }
        
        if (![[dict objectForKey:@"url"] isKindOfClass:[NSNull class]]) { self.productImageURL = [dict objectForKey:@"url"]; }
        
    }
    return self;
}


@end
