//
//  DHBlockView.m
//  GameSerial
//
//  Created by rilakkuma on 2022/10/8.
//

#import "DHBlockView.h"
#import "DHResultBlockView.h"

@interface DHBlockView ()

@property (strong, nonatomic) UIButton *playBtn;

@end
@implementation DHBlockView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.grayColor;
        [self addSubview:self.playBtn];
        [self.playBtn addTarget:self action:@selector(remindtimeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

static void (^resultDate(DHBlockView *obj))(NSString *) {
    return ^(NSString *selectValue) {
         [obj.playBtn setTitle:selectValue forState:UIControlStateNormal];
    };
};

- (void)remindtimeAction {
    DHResultBlockView *view = [[DHResultBlockView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_playBtn.frame), CGRectGetMaxY(_playBtn.frame), CGRectGetWidth(_playBtn.frame), CGRectGetHeight(_playBtn.frame))];
    [self addSubview:view];
    view.backgroundColor = UIColor.blueColor;
    
    __weak DHBlockView*weakSelf = self;
    view.resultBlock = resultDate(weakSelf);
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playBtn.backgroundColor = UIColor.redColor;
        _playBtn.frame = CGRectMake(10, 10, 50, 50);
    }
    return _playBtn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
