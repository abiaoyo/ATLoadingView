//
//  ATLoadingView.h
//  DDLoadingViewDemo
//
//  Created by liyebiao on 2021/4/22.
//  Copyright © 2021 ABiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATViewDefines.h"
#import "ATLoadingConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface ATLoadingView : UIView<ATLoading>

@property (nonatomic,assign,readonly) ATViewState state; //加载状态
@property (nonatomic,copy) void (^onBeginBlock)(void);      //点击回调
@property (nonatomic,strong) ATLoadingConfig * config;   //视力配置模型

@end

NS_ASSUME_NONNULL_END
