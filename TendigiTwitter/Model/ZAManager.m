//
//  ZAManager.m
//  TendigiTwitter
//
//  Created by Ezekiel Abuhoff on 5/16/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "ZAManager.h"
#import <AFNetworking.h>
#import <AFNetworking/UIKit+AFNetworking.h>
#import "ZATwitterAPIClient.h"
#import "ZATweet.h"
#import "ZATweetCell.h"

@interface ZAManager ()

@property (strong, nonatomic) AFHTTPSessionManager *manager;
@property (strong, nonatomic) ZATwitterAPIClient *twitterClient;

@end

@implementation ZAManager

#pragma mark - Initialize and Configure

+ (instancetype)sharedManager
{
    static ZAManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[ZAManager alloc] init];
    });
    
    return _sharedManager;
}

- (instancetype) init
{
    self = [super init];
    
    if (self)
    {
        _manager = [AFHTTPSessionManager manager];
        _twitterClient = [ZATwitterAPIClient sharedClient];
    }
    
    return self;
}



#pragma mark - Key Functionality

- (void) populateTweetsWithCompletion:(void (^)(NSArray *tweets))completionBlock
{
    [self.twitterClient verifyCredentialsWithCompletion:^(NSString *bearer) {
        [self.twitterClient getTendigiTweetsOfCount:self.maxTweets
                                       withCompletion:^(NSArray *arrayOfTweets) {
                                           NSArray *parsedTweets = [self parseArrayOfTweets:arrayOfTweets];
                                           completionBlock(parsedTweets);
                                       }];
    }];
}

- (void) setAuthorImageForTweetCell: (ZATweetCell *)tweetCell
                            withURL: (NSURL *)url
{
    [tweetCell.authorImage setImageWithURL:url];
}

#pragma mark - Parse Tweet Data

- (NSArray *) parseArrayOfTweets: (NSArray *)arrayOfTweets
{
    NSMutableArray *parsedTweets = [NSMutableArray new];
    
    for (NSDictionary *dictionaryOfTweet in arrayOfTweets) {
        [parsedTweets addObject:[self parseDictionaryOfTweet:dictionaryOfTweet]];
    };
    
    return parsedTweets;
}

- (ZATweet *) parseDictionaryOfTweet: (NSDictionary *)dictionaryOfTweet
{
    NSString *authorName = dictionaryOfTweet[@"user"][@"name"];
    NSURL *authorProfileImageURL = [NSURL URLWithString:dictionaryOfTweet[@"user"][@"profile_image_url"]];
    
    NSDateFormatter *createdAtFormatter = [NSDateFormatter new];
    [createdAtFormatter setDateFormat:@"eee MMM dd HH:mm:ss ZZZZ yyyy"];
    NSDate *createdAt = [createdAtFormatter dateFromString:dictionaryOfTweet[@"created_at"]];
    
    NSString *idStr = dictionaryOfTweet[@"id_str"];
    NSInteger favoriteCount = [dictionaryOfTweet[@"favorite_count"] integerValue];
    NSInteger retweetCount = [dictionaryOfTweet[@"retweet_count"] integerValue];
    NSString *content = dictionaryOfTweet[@"text"];
    
    return [ZATweet tweetWithAuthorName:authorName
                  authorProfileImageURL:authorProfileImageURL
                              createdAt:createdAt
                                  idStr:idStr
                          favoriteCount:favoriteCount
                           retweetCount:retweetCount
                                content:content];
}

@end
