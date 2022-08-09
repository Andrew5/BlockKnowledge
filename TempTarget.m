//
//  TempTarget.m
//  CollegePro
//
//  Created by jabraknight on 2020/3/9.
//  Copyright © 2020 jabrknight. All rights reserved.
//

#import "TempTarget.h"

@implementation TempTarget

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval target:(id)tempTarget selector:(SEL)selector userInfo:(id)userInfo repeats:(BOOL)repeats {
    TempTarget *target = [[TempTarget alloc] init];
    target.tempTarget = tempTarget;
    target.selector = selector;
    target.tempTimer = [NSTimer scheduledTimerWithTimeInterval:interval target:target selector:@selector(timerSelector:) userInfo:userInfo repeats:repeats];
    return target.tempTimer;
}

- (void)timerSelector:(NSTimer *)tempTimer {
    if (self.tempTarget && [self.tempTarget respondsToSelector:self.selector]) {
        [self.tempTarget performSelector:self.selector withObject:tempTimer.userInfo];
    }else {
        [self.tempTimer invalidate];
    }
}
/*
 注意事项：

 如果采用NSProxy的方式解除循环引用的话，

 必须在使用NSTimer的类的dealloc方法中使定时器失效即 调用invalidate方法

 可参考：https://blog.csdn.net/Z1591090/article/details/119081183

 核心本质：

 timer 使用 weakSelf 与block 使用 weakSelf 的区别

 1.当前的timer 捕捉的是对象内存，block 捕捉的是指针地址

 weakSelf： 没有对当前的内存加1操作

 NSLog(@"%ld",(long)CFGetRetainCount((__bridge CFTypeRef)self));
 __weak typeof(self) weakSelf = self;
 NSLog(@"%ld",(long)CFGetRetainCount((__bridge CFTypeRef)self));

 输出结果
 29
 29
 self和weakSelf内存地址一样，指针地址不一样
 打印指针地址和内存地址

 (lldb) po self
 <ViewController: 0x7fc484d06780>
 (lldb) po weakSelf
 <ViewController: 0x7fc484d06780>
  
 (lldb) po &weakSelf
 0x00007ffee7be4208
  
 (lldb) po &self
 0x000000010a3dbfc8

 总结
 1.self和weakSelf内存地址一样，指针地址不一样
 2.timer 捕获的是内存地址，而block捕获的是指针地址
 3.所以使用weakSelf，对timer不能解决循环引用，内存地址一样，runLoop还是强持有timer

 */
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      block:(TempTargetHandler)block
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)repeats {
    NSMutableArray *userInfoArray = [NSMutableArray arrayWithObject:[block copy]];
    if (userInfo != nil) {
        [userInfoArray addObject:userInfo];
    }
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(_timerBlockInvoke:)
                                       userInfo:[userInfoArray copy]
                                        repeats:repeats];
}

+ (void)_timerBlockInvoke:(NSArray*)userInfo {
    TempTargetHandler block = userInfo[0];
    id info = nil;
    if (userInfo.count == 2) {
        info = userInfo[1];
    }
    // or `!block ?: block();` @sunnyxx
    if (block) {
        block(info);
    }
}
- (void) fire:(NSTimer *)timer {
    if(self.tempTarget) {
        [self.tempTarget performSelector:self.selector withObject:timer.userInfo];
    } else {
        [self.tempTimer invalidate];
    }
}
@end
