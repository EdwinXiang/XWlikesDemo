//
//  XWDataModel.h
//  likesDemo
//
//  Created by Edwin on 16/4/11.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWDataModel : NSObject
/**点赞数*/
@property (nonatomic,copy) NSString * likes;

/**频道*/
@property (nonatomic,copy) NSString * channel;

/**用户点赞计数*/
@property (nonatomic, strong) NSNumber * likeActionCount;

@end
