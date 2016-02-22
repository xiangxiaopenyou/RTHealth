//
//  DropDownCell.h
//  RTHealth
//
//  Created by 项小盆友 on 14/10/23.
//  Copyright (c) 2014年 realtech. All rights reserved.
//
#import <UIKit/UIKit.h>


@interface DropDownCell : UITableViewCell {
    
    IBOutlet UILabel *textLabel;
    IBOutlet UIImageView *arrow_up;
    IBOutlet UIImageView *arrow_down;
    
    BOOL isOpen;

}

- (void) setOpen;
- (void) setClosed;

@property (nonatomic) BOOL isOpen;
@property (nonatomic, retain) IBOutlet UILabel *textLabel;
@property (nonatomic, retain) IBOutlet UIImageView *arrow_up;
@property (nonatomic, retain) IBOutlet UIImageView *arrow_down;

@end
