//
//  XWTableViewCell.m
//  likesDemo
//
//  Created by Edwin on 16/4/11.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

#import "XWTableViewCell.h"

@implementation XWTableViewCell

- (void)awakeFromNib {
     self.selectionStyle = UITableViewCellSelectionStyleNone;
    _likesBtn.userInteractionEnabled = YES;
    [_likesBtn setTitle:self.model.likes forState:UIControlStateNormal];
    _isCollectionExist = [[XWDataManager sharedManager]isDataExistByurlStr:_model.likes];
    if (_isCollectionExist) {
        _likesBtn.userInteractionEnabled = YES;
        [_likesBtn setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
    }
}

- (IBAction)likesBtnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSInteger currentNumber = btn.currentTitle.integerValue;
    NSString *newValue = [NSString stringWithFormat:@"%ld",currentNumber+1];
    [btn setTitle:newValue forState:UIControlStateNormal];
    // 点赞操作要记录在本地
    BOOL isSuc = [[XWDataManager sharedManager]updateFromModel:_model andNewValue:newValue];
    if (isSuc) {
        btn.userInteractionEnabled = NO;
        _isCollectionExist = NO;
        [_likesBtn setTitle:newValue forState:UIControlStateNormal];
        [UIView animateWithDuration:0.5 animations:^{
            _likesBtn.frame = CGRectMake(0, 0, 0, 0);
            _likesBtn.transform = CGAffineTransformMakeScale(1.5f, 1.5f);
        } completion:^(BOOL finished) {
            _likesBtn.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
            [_likesBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
