//
//  CKTableViewCell.m
//  textMethod
//
//  Created by user on 15/12/24.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKTableViewCell.h"

@interface CKTableViewCell ()

@end

@implementation CKTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubview:self.button];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _button.frame = CGRectMake(0, 10, 200, 40);
}

- (UIButton *)button
{
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"评论" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_button.titleLabel setFont:[UIFont systemFontOfSize:30]];
    }
    return _button;
}


@end
