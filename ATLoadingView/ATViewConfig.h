//
//  ATViewConfig.h
//  ATLoadingView
//
//  Created by liyebiao on 2021/4/23.
//

#import <UIKit/UIKit.h>
#import "ATViewDefines.h"
NS_ASSUME_NONNULL_BEGIN

@interface ATViewConfig : NSObject<ATViewConfigInterface>

@property (nonatomic,assign) UIEdgeInsets edgeInsets;
@property (nonatomic,strong) Class viewClass;
@property (nonatomic,strong) Class lodingConfigClass;
@property (nonatomic,strong) id<ATViewLoadingConfigInterface> loadingConfig;
@property (nonatomic,copy) void (^reLayoutConfigBlock)(UIView * superView,UIView * atView, id<ATViewLoadingConfigInterface> loadingConfig);

@end

NS_ASSUME_NONNULL_END
