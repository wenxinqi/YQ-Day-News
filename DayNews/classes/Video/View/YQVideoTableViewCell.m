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

@property (weak, nonatomic) IBOutlet UIImageView *playCoverImageV;
@property (weak, nonatomic) IBOutlet UILabel *videoTitle;
@property (weak, nonatomic) IBOutlet UILabel *lengthTime;
@property (weak, nonatomic) IBOutlet UIImageView *topicImageView;
@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@end

@implementation YQVideoTableViewCell
#warning 直接使用cell注册的方式，就不需要添加一个类方法来返回xib了
/*
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
//    static NSString *ID = @"cell";
//    
//    YQVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[YQVideoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//       
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    
//    return cell;
    //    加载xib文件
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([YQVideoTableViewCell class]) owner:nil options:nil].lastObject;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    
    }
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([YQVideoTableViewCell class]) owner:nil options:nil].lastObject;
}
*/
- (void)awakeFromNib
{
    //        设置控件的样式
    self.topicImageView.contentMode = UIViewContentModeScaleToFill;
    self.topicImageView.layer.cornerRadius = self.topicImageView.frame.size.width/2;
    self.topicImageView.layer.masksToBounds = YES;
    
    self.videoTitle.textColor = [UIColor whiteColor];
    
    self.lengthTime.textColor = [UIColor whiteColor];
    self.lengthTime.textAlignment = NSTextAlignmentCenter;
    self.lengthTime.font = [UIFont systemFontOfSize:12];
    self.lengthTime.layer.cornerRadius = 10;
    self.lengthTime.layer.masksToBounds = YES;
    
    self.dateLabel.textColor = [UIColor lightGrayColor];
    
    [super awakeFromNib];
}
//对属性videoData添加set方法
- (void)setVideoData:(YQVideoData *)videoDadta
{
    _videoData = videoDadta;
    //     给模型数据赋值
    _videoTitle.text = _videoData.title;
    _lengthTime.text = [NSDate convertTime:_videoData.length];
    [_topicImageView sd_setImageWithURL:[NSURL URLWithString:_videoData.topicImg]];
    _topicLabel.text = _videoData.topicName;
    _dateLabel.text = _videoData.ptime;
    //    设置占位图片，在未加载完成时
    [_playCoverImageV sd_setImageWithURL:[NSURL URLWithString:_videoData.cover] placeholderImage:[UIImage imageNamed:@"sc_video_play_fs_loading_bg.png"]];
    
}




//对cell的排布进行控制
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= YQVideoCellMargin;
    frame.origin.y += YQVideoCellMargin;
    
    [super setFrame:frame];
}
@end
