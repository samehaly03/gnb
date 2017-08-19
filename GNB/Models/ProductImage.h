//
//  ProductImage.h
//  GNB
//
//  Created by Macintosh HD on 8/18/17.
//  Copyright © 2017 GNB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductImage : NSObject

@property (nonatomic, strong) NSNumber *productImageWidth;
@property (nonatomic, strong) NSNumber *productImageHeight;
@property (nonatomic, strong) NSString *productImageURL;

- (instancetype)initProductImageWithDictionary:(NSDictionary *)dict;

@end
