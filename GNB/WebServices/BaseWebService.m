//
//  BaseWebService.m
//  BAuto
//
//  Created by Macintosh HD on 2/11/17.
//  Copyright © 2017 Sahab. All rights reserved.
//

#import "BaseWebService.h"

@implementation BaseWebService

- (id)init
{
    self = [super init];
    
    if (self) {
        
        self.baseUrl = @"http://grapesnberries.getsandbox.com/";
        
        self.config = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:self.config];
        
        self.request = [[NSMutableURLRequest alloc] initWithURL:self.url];
        
        self.request.HTTPMethod = @"GET";
        
        [self.request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [self.request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
    }
    return self;
}


@end
