//
//  ProductsWebService.m
//  GNB
//
//  Created by Macintosh HD on 8/18/17.
//  Copyright © 2017 GNB. All rights reserved.
//

#import "ProductsWebService.h"
#import "Product.h"

@implementation ProductsWebService



- (void)getProductsFrom:(int)start max:(int)count WithSuccess:(void (^)(NSMutableArray *data))success
                       failure:(void (^)(NSError *error))failure
{
    
    self.serviceName = [NSString stringWithFormat:@"products?start=%i&count=%i", start, count];
    
    self.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", self.baseUrl, self.serviceName]];
    
    NSError *error = nil;
    
    if (!error)
    {
        
        NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:self.url
                                                     completionHandler:^(NSData *data, NSURLResponse *response,
                                                                         NSError *error) {
                                                         if (!error)
                                                         {
                                                             if ([response isKindOfClass:[NSHTTPURLResponse class]])
                                                             {
                                                                 
                                                                 NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
                                                                 
                                                                 if (statusCode != 200)
                                                                 {
                                                                 
                                                                     NSMutableDictionary* details = [NSMutableDictionary dictionary];
                                                                     [details setValue:@"HTTP ERROR" forKey:NSLocalizedDescriptionKey];

                                                                     error = [NSError errorWithDomain:@"GNB" code:statusCode userInfo:details];
                                                                     
                                                                     failure(error);
                                                                 }
                                                                 else
                                                                 {
                                                                     NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                                                                     
                                                                     NSMutableArray *productsArray = [[NSMutableArray alloc] init];
                                                                     
                                                                     
                                                                     for (NSDictionary *dict in array)
                                                                     {
                                                                         if ([dict isKindOfClass:[NSDictionary class]]) {
                                                                             
                                                                             Product *product = [[Product alloc] initProductWithDictionary:dict];
                                                                             
                                                                             [productsArray addObject:product];
                                                                             
                                                                             product = nil;
                                                                             
                                                                         }
                                                                         
                                                                         
                                                                     }
                                                                     
                                                                     success(productsArray);
                                                                     
                                                                 }
                                                             }

                                                         }
                                                         else
                                                         {
                                                            failure(error);
                                                             
                                                         }
                                                     }];
        [dataTask resume];
    }
    else
    {
        failure(error);
    }
    
}



@end
