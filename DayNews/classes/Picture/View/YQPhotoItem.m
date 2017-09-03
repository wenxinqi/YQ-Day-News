//
//  YQPhotoItem.m
//  DayNews
//
//  Created by 奇奇 on 2017/8/31.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQPhotoItem.h"
#import "YQPictureData.h"

@interface YQPhotoItem ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation YQPhotoItem

- (void)setPictureData:(YQPictureData *)pictureData
{
    _pictureData = pictureData;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:pictureData.small_url]];
    
    self.titleLabel.text = pictureData.title;
}

@end
