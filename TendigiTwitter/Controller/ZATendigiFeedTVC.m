//
//  ZATendigiFeedTVC.m
//  TendigiTwitter
//
//  Created by Ezekiel Abuhoff on 5/13/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "ZATendigiFeedTVC.h"
#import "ZAManager.h"
#import "ZATweet.h"
#import "ZATweetCell.h"

@interface ZATendigiFeedTVC ()

@property (strong, nonatomic) ZAManager *manager;
@property (strong, nonatomic) NSArray *tweets;
@property (strong, nonatomic) NSOperationQueue *mainQueue;
@property (strong, nonatomic) NSOperationQueue *imageQueue;

@end

@implementation ZATendigiFeedTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.manager = [ZAManager sharedManager];
    self.mainQueue = [NSOperationQueue mainQueue];
    self.imageQueue = [NSOperationQueue new];
    
    [self.manager populateTweetsWithCompletion:^(NSArray *tweets) {
        [self.mainQueue addOperationWithBlock:^{
            self.manager.tweets = tweets;
            [self.tableView reloadData];
//            [self initiateImageGetsForAllTweets];
        }];
    }];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.manager.tweets)
    {
        return [self.manager.tweets count];
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.manager.tweets)
    {
        NSLog(@"%d",indexPath.row);
        NSInteger thisRow = indexPath.row;
        ZATweet *thisTweet = self.manager.tweets[thisRow];
        
        ZATweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"tweetCell" forIndexPath:indexPath];
        [cell configureCellWithAuthorImage:nil
                                    author:thisTweet.authorName
                                   content:thisTweet.content];
        
        [self.manager setAuthorImageForTweetCell:cell withURL:thisTweet.authorProfileImageURL];
        
        return cell;
    }
    
    return  nil;
}

#pragma mark - Utility Methods

//- (void) updateTableWithTweetData: (NSArray *)tweets
//{
//    self.tweets = tweets;
//    [self.tableView reloadData];
//}

//- (ZATweetCell *) configureCell: (ZATweetCell *)cell
//                          tweet: (ZATweet *)tweet
//                    authorImage: (UIImage *)authorImage
//{
//    ZATweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"tweetCell" forIndexPath:indexPath];
//    [cell configureCellWithAuthorImage:authorImage
//                                author:tweet.authorName
//                               content:tweet.content];
//    
//    return cell;
//}

//- (void) initiateImageGetsForAllTweets
//{
//    for (ZATweet *tweet in self.manager.tweets) {
//        
//        [self.manager getImageDataForURL:[tweet.authorProfileImageURL absoluteString] withCompletion:^(NSData *imageData) {
//            
//            [self.mainQueue addOperationWithBlock:^{
//                
//                UIImage *authorImage = [UIImage imageWithData:imageData];
//                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.manager.tweets indexOfObject:tweet] inSection:0];
//                ZATweetCell *cell = (ZATweetCell *)[self.tableView cellForRowAtIndexPath:indexPath];
//                [cell configureCellWithAuthorImage:authorImage
//                                            author:tweet.authorName
//                                           content:tweet.content];
//            }];
//        }];
//    }
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
