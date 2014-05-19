//
//  ZAManager.h
//  TendigiTwitter
//
//  Created by Ezekiel Abuhoff on 5/16/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZATweetCell;

@interface ZAManager : NSObject

// Public Properties

@property (strong, nonatomic) NSArray *tweets;
@property (nonatomic) NSInteger maxTweets;

// Instantiation and Configuration

+ (instancetype) sharedManager;

// Key Functionality

- (void) populateTweetsWithCompletion:(void (^)(NSArray *tweets))completionBlock;
- (void) setAuthorImageForTweetCell: (ZATweetCell *)tweetCell
                            withURL: (NSURL *)url;

@end
