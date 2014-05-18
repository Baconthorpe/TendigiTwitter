//
//  ZATweet.h
//  TendigiTwitter
//
//  Created by Ezekiel Abuhoff on 5/16/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZATweet : NSObject

@property (readonly, strong, nonatomic) NSString *authorName;
@property (readonly, strong, nonatomic) NSURL *authorProfileImageURL;

@property (readonly, strong, nonatomic) NSDate *createdAt;
@property (readonly, strong, nonatomic) NSString *idStr;

@property (readonly, nonatomic) NSInteger favoriteCount;
@property (readonly, nonatomic) NSInteger retweetCount;

@property (readonly, strong, nonatomic) NSString *content;


+ (instancetype) tweetWithAuthorName: (NSString *)authorName
               authorProfileImageURL: (NSURL *)authorProfileImageURL
                           createdAt: (NSDate *)createdAt
                               idStr: (NSString *)idStr
                       favoriteCount: (NSInteger)favoriteCount
                        retweetCount: (NSInteger)retweetCount
                             content: (NSString *)content;

@end
