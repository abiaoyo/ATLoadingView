//
//  ATViewObject.m
//  ATLoadingView
//
//  Created by liyebiao on 2021/4/23.
//

#import "ATViewObject.h"
#import "ATViewConfig.h"

@implementation ATViewObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        _config = [[ATViewConfig alloc] init];
    }
    return self;
}

- (void)beginLoading {
    [self.ownerView beginLoading];
}

- (void)empty {
    [self.ownerView empty];
}

- (void)endLoading {
    [self.ownerView endLoading];
}

- (void)error {
    [self.ownerView error];
}

- (void)noNetwork {
    [self.ownerView noNetwork];
}

@end
