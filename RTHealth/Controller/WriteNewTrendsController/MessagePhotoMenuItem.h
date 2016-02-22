//
//  MessagePhotoMenuItem.h
//  RTHealth
//
//  Created by 项小盆友 on 14/11/4.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessagePhotoMenuItem;
@protocol MessagePhotoItemDelegate <NSObject>

- (void)messagePhotoItemView:(MessagePhotoMenuItem *)messagePhotoItemView
didSelectDeleteButtonAtIndex:(NSInteger)index;

@end

@interface MessagePhotoMenuItem : UIView

@property(nonatomic,weak)id<MessagePhotoItemDelegate>delegate;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong) UIImage *contentImage;
@end
