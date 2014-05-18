//
//  ZATweet.m
//  TendigiTwitter
//
//  Created by Ezekiel Abuhoff on 5/16/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "ZATweet.h"

@implementation ZATweet

+ (instancetype) tweetWithAuthorName: (NSString *)authorName
               authorProfileImageURL: (NSURL *)authorProfileImageURL
                           createdAt: (NSDate *)createdAt
                               idStr: (NSString *)idStr
                       favoriteCount: (NSInteger)favoriteCount
                        retweetCount: (NSInteger)retweetCount
                             content: (NSString *)content
{
    return [[ZATweet alloc] initWithAuthorName:authorName
                         authorProfileImageURL:authorProfileImageURL
                                     createdAt:createdAt
                                         idStr:idStr
                                 favoriteCount:favoriteCount
                                  retweetCount:retweetCount
                                       content:content];
}

- (instancetype) initWithAuthorName: (NSString *)authorName
              authorProfileImageURL: (NSURL *)authorProfileImageURL
                          createdAt: (NSDate *)createdAt
                              idStr: (NSString *)idStr
                      favoriteCount: (NSInteger)favoriteCount
                       retweetCount: (NSInteger)retweetCount
                            content: (NSString *)content
{
    self = [super init];
    
    if (self)
    {
        _authorName = authorName;
        _authorProfileImageURL = authorProfileImageURL;
        _createdAt = createdAt;
        _idStr = idStr;
        _favoriteCount = favoriteCount;
        _retweetCount = retweetCount;
        _content = content;
    }
    
    return self;
}

@end
