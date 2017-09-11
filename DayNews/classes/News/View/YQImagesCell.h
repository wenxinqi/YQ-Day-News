//
//  YQImagesCell.h
//  DayNews
//
//  Created by 奇奇 on 2017/9/5.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YQTotalDaTaModel;
@interface YQImagesCell : UITableViewCell
@property (nonatomic , strong)YQTotalDaTaModel *dataModel;

/**
 *  标题
 */
@property (nonatomic , weak) UILabel *titleL;
/**
 *  跟帖数
 */
@property (nonatomic , weak) UILabel *lblReply;

/**
 *  多图
 */
@property (nonatomic , weak) UIImageView *image1;
@property (nonatomic , weak) UIImageView *image2;
@property (nonatomic , weak) UIImageView *image3;


+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
