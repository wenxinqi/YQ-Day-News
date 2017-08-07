//
//  YQVideoTableViewCell.m
//  DayNews
//
//  Created by 奇奇 on 2017/8/6.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQVideoTableViewCell.h"
#import "YQVideoData.h"




@interface YQVideoTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *videoTitle;
@property (weak, nonatomic) IBOutlet UILabel *lengthTime;
@property (weak, nonatomic) IBOutlet UIImageView *topicImageView;
@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@end

@implementation YQVideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

//对属性videoData添加set方法
- (void)setVideoData:(YQVideoData *)videoData
{
    self.videoData = videoData;

//     给模型数据赋值
    _videoTitle.text = videoData.videoTitle;
    _lengthTime.text = videoData.lengthTime;
    [_topicImageView sd_setImageWithURL:[NSURL URLWithString:videoData.topicImage]];
    _topicLabel.text = videoData.topicTitle;
    _dateLabel.text = videoData.videoDate;
   
}
@end
