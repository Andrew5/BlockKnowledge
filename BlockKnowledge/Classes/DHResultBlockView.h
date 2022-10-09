//
//  DHResultBlockView.h
//  PSSPro_Example
//
//  Created by rilakkuma on 2022/10/8.
//  Copyright © 2022 jabraknight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHResultBlockView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^ResultBlock)(NSString * _Nullable selectValue);

@interface DHResultBlockView : UIView
@property (nullable, nonatomic, copy) ResultBlock resultBlock;
@property (strong, nonatomic) UIButton *playBtn;

@end

NS_ASSUME_NONNULL_END
