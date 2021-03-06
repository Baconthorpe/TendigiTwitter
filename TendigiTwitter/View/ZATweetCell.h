//
//  ZATweetCell.h
//  TendigiTwitter
//
//  Created by Ezekiel Abuhoff on 5/14/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZATweetCell : UITableViewCell

// Public Properties

@property (weak, nonatomic) IBOutlet UIImageView *authorImage;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

// Instantiation and Configuration

- (instancetype) configureCellWithAuthorImage: (UIImage *)authorImage
                                       author: (NSString *)author
                                      content: (NSString *)content;

@end
