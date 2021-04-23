//
//  ATViewDefines.h
//  DDLoadingViewDemo
//
//  Created by liyebiao on 2021/4/22.
//  Copyright © 2021 ABiang. All rights reserved.
//

#ifndef ATViewDefines_h
#define ATViewDefines_h

#import <UIKit/UIKit.h>

#define ATViewForRefreshHeaderTag 1001001
#define ATViewForRefreshFooterTag 1001002

typedef NS_ENUM(NSUInteger, ATViewState) {
    ATViewStateIdl = 0,
    ATViewStateBegin,
    ATViewStateEnd,
    ATViewStateError,
    ATViewStateEmpty,
    ATViewStateNoNetwork,
};

@protocol ATViewLoadingConfigInterface <NSObject>
@required
@property (nonatomic,strong) UIColor * backgroundColor;
@end

@protocol ATViewConfigInterface <NSObject>
@required
@property (nonatomic,assign) UIEdgeInsets edgeInsets;
@property (nonatomic,strong) Class viewClass;
@property (nonatomic,strong) Class lodingConfigClass;
@property (nonatomic,strong) id<ATViewLoadingConfigInterface> loadingConfig;
@property (nonatomic,copy) void (^reLayoutConfigBlock)(UIView * superView,UIView * atView, id<ATViewLoadingConfigInterface> loadingConfig);
@end


@protocol ATViewInterface <NSObject>
@required
- (void)beginLoading;
- (void)endLoading;
- (void)empty;
- (void)error;
- (void)noNetwork;

@end


#endif /* ATViewDefines_h */
