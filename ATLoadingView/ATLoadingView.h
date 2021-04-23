//
//  ATLoadingView.h
//  DDLoadingViewDemo
//
//  Created by liyebiao on 2021/4/22.
//  Copyright © 2021 ABiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATViewDefines.h"
NS_ASSUME_NONNULL_BEGIN

@interface ATLoadingView : UIView<ATViewInterface>

@property (nonatomic,assign,readonly) ATViewState state;
@property (nonatomic,strong) id<ATViewConfigInterface> config;
@property (nonatomic,copy) void (^onLoadingBlock)(void);

@end

NS_ASSUME_NONNULL_END
