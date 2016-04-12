//
//  XWTableViewCell.h
//  likesDemo
//
//  Created by Edwin on 16/4/11.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWDataModel.h"
#import "XWDataManager.h"
@interface XWTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *likesBtn;
@property (nonatomic,strong) XWDataModel *model;
@property (nonatomic,assign) BOOL isCollectionExist;
@end
