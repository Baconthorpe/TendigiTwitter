//
//  ZAManager.h
//  TendigiTwitter
//
//  Created by Ezekiel Abuhoff on 5/16/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZAManager : NSObject

+ (instancetype) sharedManager;

- (void) configureMaxTweets: (NSInteger)max;

- (void) populateTweetsWithCompletion:(void (^)(NSArray *tweets))completionBlock;

@end
