//
//  UIView+ATLoading.h
//  DDLoadingViewDemo
//
//  Created by liyebiao on 2021/4/22.
//  Copyright © 2021 ABiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATViewDefines.h"
#import "ATLoadingConfig.h"
NS_ASSUME_NONNULL_BEGIN

#define ATLoadingForRefreshHeaderTag 1001001
#define ATLoadingForRefreshFooterTag 1001002

@interface UIView (ATLoading)

@property (nonatomic,copy) Class (^atLoadingViewClass)(void);//ATLoadingView sub class
@property (nonatomic,copy) Class (^atLoadingConfigClass)(void);//ATLoadingConfig sub class.
@property (nonatomic,copy) void (^atLoadingConfigModelBlock)(UIView * superView, ATLoadingConfig * config);
@property (nonatomic,copy) void (^onAtLoadingBeginBlock)(void);

@end

@interface UIView (ATLoadingExt)<ATLoading>

- (void)atLoadingBegin:(BOOL)scrollEnable;
- (void)atLoadingError:(BOOL)scrollEnable;
- (void)atLoadingEmpty:(BOOL)scrollEnable;
- (void)atLoadingNoNetwork:(BOOL)scrollEnable;

@end


NS_ASSUME_NONNULL_END
