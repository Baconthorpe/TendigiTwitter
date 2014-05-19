//
//  ZATweetCell.m
//  TendigiTwitter
//
//  Created by Ezekiel Abuhoff on 5/14/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "ZATweetCell.h"
#import <AFNetworking/UIKit+AFNetworking.h>

@implementation ZATweetCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Instantiation and Configuration

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (instancetype) configureCellWithAuthorImage: (UIImage *)authorImage
                                       author: (NSString *)author
                                      content: (NSString *)content
{
    self.authorImage.image = authorImage;
    self.authorLabel.text = author;
    self.contentLabel.text = content;
    
    return self;
}


@end
