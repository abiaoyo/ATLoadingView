//
//  ATViewConfig.m
//  ATLoadingView
//
//  Created by liyebiao on 2021/4/23.
//

#import "ATViewConfig.h"
#import "ATViewLoadingConfig.h"
#import "ATLoadingSimpleView.h"
#import "ATLoadingSimpleConfig.h"

@implementation ATViewConfig

- (instancetype)init{
    self = [super init];
    if (self) {
        self.loadingConfig = [[ATViewLoadingConfig alloc] init];
        self.viewClass = ATLoadingSimpleView.class;
        self.lodingConfigClass = ATLoadingSimpleConfig.class;
    }
    return self;
}

@end
