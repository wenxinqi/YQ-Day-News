//
//  YQBigImageCell.m
//  DayNews
//
//  Created by 奇奇 on 2017/9/5.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQBigImageCell.h"
#import "YQTotalDaTaModel.h"

@implementation YQBigImageCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"bigImagecell";
    YQBigImageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YQBigImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, YQSCREEN_WIDTH-20, 20)];
        if (YQSCREEN_WIDTH == 320) {
            titleL.font = [UIFont systemFontOfSize:15];
        }else{
            titleL.font = [UIFont systemFontOfSize:16];
        }
        [self addSubview:titleL];
        self.titleL = titleL;
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleL.frame)+10, YQSCREEN_WIDTH-20, 0.3*(YQSCREEN_WIDTH-20))];
        imageview.backgroundColor = [UIColor grayColor];
        [self addSubview:imageview];
        self.image1 = imageview;
        
        UILabel *scrL = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageview.frame), YQSCREEN_WIDTH-20, 40)];
        scrL.numberOfLines = 0;
        scrL.font = [UIFont systemFontOfSize:14];
        scrL.textColor = [UIColor lightGrayColor];
        [self addSubview:scrL];
        self.lblSubtitle = scrL;
        
        CGFloat x = YQSCREEN_WIDTH-5-100;
        CGFloat y = CGRectGetMaxY(imageview.frame)+30;
        CGFloat w = 100;
        CGFloat h = 15;
        UILabel *replyL = [[UILabel alloc]init];
        replyL.frame = CGRectMake(x, y, w, h);
        replyL.textAlignment = NSTextAlignmentCenter;
        replyL.font = [UIFont systemFontOfSize:10];
        replyL.textColor = [UIColor darkGrayColor];
        [self addSubview:replyL];
        self.lblReply = replyL;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(replyL.frame) + 10, YQSCREEN_WIDTH - 20, 1)];
        [self addSubview:line];
    }
    return self;
}


- (void)setDataModel:(YQTotalDaTaModel *)dataModel
{
    _dataModel = dataModel;
    
    [self.image1 sd_setImageWithURL:[NSURL URLWithString:self.dataModel.imgsrc] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    self.titleL.text = self.dataModel.title;
    self.lblSubtitle.text = self.dataModel.digest;
    
    CGFloat count =  [self.dataModel.replyCount intValue];
    NSString *displayCount;
    if (count > 10000) {
        displayCount = [NSString stringWithFormat:@"%.1f万跟帖",count/10000];
    }else{
        displayCount = [NSString stringWithFormat:@"%.0f跟帖",count];
    }
    self.lblReply.text = displayCount;
    
    self.lblReply.width = [self.lblReply.text stringWithMaxSize:CGSizeMake(200, MAXFLOAT) andFont:[UIFont systemFontOfSize:10]].size.width;
    
    self.lblReply.width += 10;
    self.lblReply.x = YQSCREEN_WIDTH - 10 - self.lblReply.width;
    
    [self.lblReply.layer setBorderWidth:1];
    [self.lblReply.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [self.lblReply.layer setCornerRadius:5];
    self.lblReply.clipsToBounds = YES;
}

@end
