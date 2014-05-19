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

@property (strong, nonatomic) NSArray *tweets;


+ (instancetype) sharedManager;

- (void) configureMaxTweets: (NSInteger)max;

//- (NSArray *) tweets;
//- (void) setTweets:(NSArray *)tweets;

- (void) populateTweetsWithCompletion:(void (^)(NSArray *tweets))completionBlock;

//- (void) getImageDataForURL: (NSString *)urlString
//             withCompletion: (void (^)(NSData *imageData))completionBlock;

- (void) setAuthorImageForTweetCell: (ZATweetCell *)tweetCell
                            withURL: (NSURL *)url;

@end
