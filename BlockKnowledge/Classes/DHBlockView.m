//
//  DHBlockView.m
//  GameSerial
//
//  Created by rilakkuma on 2022/10/8.
//

#import "DHBlockView.h"
#import "DHResultBlockView.h"
#import "DHPerson.h"

@interface DHBlockView ()

@property (strong, nonatomic) UIButton *playBtn;
@property (strong, nonatomic) DHPerson *per;

@end
@implementation DHBlockView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.grayColor;
        [self addSubview:self.playBtn];
        [self.playBtn addTarget:self action:@selector(remindtimeAction) forControlEvents:UIControlEventTouchUpInside];
        DHPerson * per = [DHPerson new];
        per.name = @"zhangsan";
        per.height = 1.2;
        self.per = per;
        // kvo 为per.name添加观察者

        [per addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        
        [NSNotificationCenter.defaultCenter addObserverForName:@"PPProfilePopToRootNotification" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
                NSLog(@"输出--%@",[note object]);
        }];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    /** 打印新老值 */
    
    // 从打印结果看 分别打印出了 name 与 height的新老值
    
    NSLog(@"old : %@ new : %@",[change objectForKey:@"old"],[change objectForKey:@"new"]);
    
    // NSLog(@"keypath : %@",keyPath);
    
    // NSLog(@"change : %@",change);
    
}

+ (NSString *)getWeekDayString:(NSInteger)weekday {
    
    NSString *weekString = NSString.string;
    switch (weekday) {
        case 1:
            weekString = @"周日";
            break;
        case 2:
            weekString = @"周一";
            break;
        case 3:
            weekString = @"周二";
            break;
        case 4:
            weekString = @"周三";
            break;
        case 5:
            weekString = @"周四";
            break;
        case 6:
            weekString = @"周五";
            break;
        case 7:
            weekString = @"周六";
            break;
        default:
            break;
    }
    return  weekString;
}

static void buttonSetTitle(NSString **result, NSDate *selectDate, NSString **strDate, NSString **strHourDate) {
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:selectDate];
    *result = [DHBlockView getWeekDayString:comps.weekday];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    *strDate = [dateFormatter stringFromDate:selectDate];
    dateFormatter.dateFormat = @"HH:mm";
    *strHourDate = [dateFormatter stringFromDate:selectDate];
}
static void (^resultDate(DHBlockView *obj))(NSDate *, NSString *) {
    __weak DHBlockView*weakSelf = obj;
    return ^(NSDate *selectDate, NSString *selectValue) {
        NSString * result;
        NSString * strDate;
        NSString * strHourDate;
        buttonSetTitle(&result, selectDate, &strDate, &strHourDate);
        [weakSelf.playBtn setTitle:selectValue forState:UIControlStateNormal];
        NSLog(@"输出--%@",[NSString stringWithFormat:@"%@ %@ %@",strDate,result,strHourDate]);
    };
};

- (void)remindtimeAction {
    
    DHResultBlockView *view = [[DHResultBlockView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_playBtn.frame), CGRectGetMaxY(_playBtn.frame), CGRectGetWidth(_playBtn.frame), CGRectGetHeight(_playBtn.frame)-15)];
    [self addSubview:view];
    view.backgroundColor = UIColor.blueColor;
    __weak DHBlockView*weakSelf = self;
    view.resultBlock = resultDate(weakSelf);
    self.per.name = @"helloworld";
    self.per.height = 3.3;
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playBtn.backgroundColor = UIColor.redColor;
        _playBtn.frame = CGRectMake(10, 10, 50, 50);
    }
    return _playBtn;
}

- (void)dealloc {
    NSLog(@"输出--%@",@"释放了");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
