//
//  ZATwitterAPIClient.m
//  TendigiTwitter
//
//  Created by Ezekiel Abuhoff on 5/13/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "ZATwitterAPIClient.h"
#import "ZAPrivateConstants.h"
#import "AFNetworking.h"

@implementation ZATwitterAPIClient

- (NSString  *) encodeConsumerKeyAndSecret
{
    NSString *unencodedCredentials = [NSString stringWithFormat:@"%@:%@",TWITTER_API_KEY,TWITTER_API_SECRET];
    
    NSString *encodedCredentials = [[unencodedCredentials dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    
    return encodedCredentials;
}

@end
