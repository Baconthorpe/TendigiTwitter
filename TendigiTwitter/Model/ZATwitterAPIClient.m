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
#import "STTwitterAppOnly.h"
#import "ZATweet.h"

@interface ZATwitterAPIClient ()

@property (strong, nonatomic) AFHTTPSessionManager *manager;
@property (strong, nonatomic) STTwitterAppOnly *sttwitter;

@property (strong, nonatomic) NSArray *tweets;
@property (nonatomic) NSInteger maxTweets;

@end

@implementation ZATwitterAPIClient

#pragma mark - Initialize and Configure

+ (instancetype)sharedClient
{
    static ZATwitterAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ZATwitterAPIClient alloc] init];
    });
    
    return _sharedClient;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _sttwitter = [STTwitterAppOnly twitterAppOnlyWithConsumerName:@"Tendigi Tweets" consumerKey:TWITTER_API_KEY consumerSecret:TWITTER_API_SECRET];
        _tweets = [NSArray new];
    }
    
    return self;
}

- (void) configureMaxTweets: (NSInteger)max
{
    self.maxTweets = max;
}

#pragma mark - Verify Credentials

- (void) verifyCredentialsWithCompletion: (void (^)(NSString *bearer))completionBlock;
{
    [self.sttwitter verifyCredentialsWithSuccessBlock:^(NSString *username) {
        self.sttwitter.bearerToken = username;
        NSLog(@"%@",self.sttwitter.bearerToken);
        completionBlock(username);
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - Fetch Tweets

- (void) fetchTendigiTweetsOfCount: (NSInteger)tweetCount
                    withCompletion: (void (^)(NSArray *arrayOfTweets))completionBlock
{
    NSString *resourceString = [NSString stringWithFormat:@"/1.1/statuses/user_timeline.json?screen_name=TENDIGI&count=%d",tweetCount];
    
    [self.sttwitter fetchResource:resourceString
                       HTTPMethod:@"GET"
                    baseURLString:@"https://api.twitter.com"
                       parameters:@{ @"access_token" : self.sttwitter.bearerToken }
              uploadProgressBlock:^(NSInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite) {
                  
              } downloadProgressBlock:^(id request, id response) {
                  
              } successBlock:^(id request, NSDictionary *requestHeaders, NSDictionary *responseHeaders, id response) {
                  NSLog(@"Response: %@",response);
                  completionBlock(response);
              } errorBlock:^(id request, NSDictionary *requestHeaders, NSDictionary *responseHeaders, NSError *error) {
                  NSLog(@"Error: %@",error);
              }];
}

- (NSString  *) encodeConsumerKeyAndSecret
{
    NSString *unencodedCredentials = [NSString stringWithFormat:@"%@:%@",TWITTER_API_KEY,TWITTER_API_SECRET];
    
    NSString *encodedCredentials = [[unencodedCredentials dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    
    return encodedCredentials;
}

- (AFHTTPSessionManager *) manager
{
    if (!_manager)
    {
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"api.twitter.com"]];
        _manager.requestSerializer=[AFHTTPRequestSerializer serializer];
        
        [_manager.requestSerializer setValue:[NSString stringWithFormat: @"Basic %@",[self encodeConsumerKeyAndSecret]] forHTTPHeaderField:@"Authorization"];
        [_manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    }
    
    return _manager;
}

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

- (void) getBearerToken
{
    NSURL *url = [NSURL URLWithString:@"api.twitter.com/oauth2/token"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:[NSString stringWithFormat:@"Basic %@",[self encodeConsumerKeyAndSecret]] forHTTPHeaderField:@"Authorization"];
    [request addValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    AFHTTPRequestOperation *newOp = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    NSString *bodyString = @"grant_type=client_credentials";
    request.HTTPBody = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    
    [newOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog (@"Response: %@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog (@"Error: %@",error);
    }];
    
    [newOp start];
}

//- (void) flagPostID:(NSString *)postObjectID
//     withCompletion:(void (^)(NSDictionary *))completion
//{
//    NSString *parsePostURL = [NSString stringWithFormat:@"https://api.parse.com/1/classes/GRTPost/%@", postObjectID];
//    NSURL *url = [NSURL URLWithString:parsePostURL];
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request addValue:self.restAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
//    [request addValue:self.appID forHTTPHeaderField:@"X-Parse-Application-Id"];
//    
//    AFHTTPRequestOperation *newOp = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    
//    NSString *json = @"{\"isFlagged\":true}";
//    request.HTTPBody = [json dataUsingEncoding:NSUTF8StringEncoding];
//    request.HTTPMethod = @"PUT";
//    
//    [newOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"Parse Flag successful. Update Post Response: %@",responseObject);
//        completion(responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Parse Flag unsuccessful. Update Post Error:%@",error);
//    }];
//    
//    [newOp start];
//    
//}

@end
