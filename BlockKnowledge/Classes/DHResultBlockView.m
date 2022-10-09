//
//  DHResultBlockView.m
//  PSSPro_Example
//
//  Created by rilakkuma on 2022/10/8.
//  Copyright © 2022 jabraknight. All rights reserved.
//

#import "DHResultBlockView.h"

@implementation DHResultBlockView
- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playBtn.backgroundColor = UIColor.blackColor;
        _playBtn.frame = CGRectMake(0, 0, 50, 30);
        [_playBtn setTitle:@"显示" forState:UIControlStateNormal];
        [_playBtn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    }
    return _playBtn;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.grayColor;
        [self addSubview:self.playBtn];
        [self.playBtn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)test {
    if (self.resultBlock) {
        self.resultBlock(@"测试");
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
