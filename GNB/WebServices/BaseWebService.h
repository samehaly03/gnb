//
//  BaseWebService.h
//  BAuto
//
//  Created by Macintosh HD on 2/11/17.
//  Copyright © 2017 Sahab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseWebService : NSObject

@property (nonatomic, strong) NSString *baseUrl;
@property (nonatomic, strong) NSString *serviceName;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionConfiguration *config;
@property (nonatomic, strong) NSMutableURLRequest *request;

@end
