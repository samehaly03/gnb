//
//  ProductsWebService.h
//  GNB
//
//  Created by Macintosh HD on 8/18/17.
//  Copyright © 2017 GNB. All rights reserved.
//

#import "BaseWebService.h"

@interface ProductsWebService : BaseWebService

- (void)getProductsFrom:(int)start max:(int)count WithSuccess:(void (^)(NSMutableArray *data))success
                failure:(void (^)(NSError *error))failure;

@end
