//
//  ZATweetCell.m
//  TendigiTwitter
//
//  Created by Ezekiel Abuhoff on 5/14/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "ZATweetCell.h"

@implementation ZATweetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype) tweetCellWithAuthorImage: (UIImage *)authorImage
                                   author: (NSString *)author
                                  content: (NSString *)content
{
    ZATweetCell *newCell = [ZATweetCell new];
    
    newCell.authorImage.image = authorImage;
    newCell.authorLabel.text = author;
    newCell.contentLabel.text = content;
    
    return newCell;
}


@end
