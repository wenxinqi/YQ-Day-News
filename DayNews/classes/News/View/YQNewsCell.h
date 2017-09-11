//
//  YQNewsCell.h
//  DayNews
//
//  Created by 奇奇 on 2017/9/5.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YQTotalDaTaModel;
@interface YQNewsCell : UITableViewCell
@property (nonatomic , strong) YQTotalDaTaModel *dataModel;


/**
 *  图片
 */
@property (weak, nonatomic) UIImageView *imgIcon;
/**
 *  标题
 */
@property (weak, nonatomic) UILabel *lblTitle;
/**
 *  回复数
 */
@property (weak, nonatomic) UILabel *lblReply;
/**
 *  描述
 */
@property (weak, nonatomic) UILabel *lblSubtitle;
/**
 *  第二张图片（如果有的话）
 */
@property (weak, nonatomic) UIImageView *imgOther1;
/**
 *  第三张图片（如果有的话）
 */
@property (weak, nonatomic) UIImageView *imgOther2;
/**
 *  来源
 */
@property (nonatomic , weak) UILabel *resorceL;


/**
 *  类方法返回可重用的id
 */
+ (NSString *)idForRow:(YQTotalDaTaModel *)NewsModel;

/**
 *  类方法返回行高
 */
+ (CGFloat)heightForRow:(YQTotalDaTaModel *)NewsModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
