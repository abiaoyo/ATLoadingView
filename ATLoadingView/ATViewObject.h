//
//  ATViewObject.h
//  ATLoadingView
//
//  Created by liyebiao on 2021/4/23.
//

#import <UIKit/UIKit.h>
#import "ATViewDefines.h"
NS_ASSUME_NONNULL_BEGIN


@interface ATViewObject : NSObject<ATViewInterface>

@property (nonatomic,weak) id<ATViewInterface> ownerView;
@property (nonatomic,strong,readonly) id<ATViewConfigInterface> config;
@property (nonatomic,copy) void (^onLoadingBlock)(void);

@end

NS_ASSUME_NONNULL_END
