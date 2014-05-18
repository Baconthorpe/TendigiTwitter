//
//  ZATwitterAPIClient.h
//  TendigiTwitter
//
//  Created by Ezekiel Abuhoff on 5/13/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZATwitterAPIClient : NSObject

// Initialize and Configure
+ (instancetype)sharedClient;
- (void) configureMaxTweets: (NSInteger)max;

// Verify Credentials
- (void) verifyCredentialsWithCompletion: (void (^)(NSString *bearer))completionBlock;

// Fetch Tweets
- (void) fetchTendigiTweetsOfCount: (NSInteger)tweetCount
                    withCompletion: (void (^)(NSArray *arrayOfTweets))completionBlock;

@end
