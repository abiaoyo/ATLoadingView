//
//  ATLoadingView.m
//  DDLoadingViewDemo
//
//  Created by liyebiao on 2021/4/22.
//  Copyright © 2021 ABiang. All rights reserved.
//

#import "ATLoadingView.h"

@implementation ATLoadingView

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setConfig:(id<ATViewConfigInterface>)config{
    _config = config;
    self.backgroundColor = config.loadingConfig.backgroundColor;
}

- (void)beginLoading{
    if(_state != ATViewStateBegin){
        _state = ATViewStateBegin;
        if(self.onLoadingBlock){
            self.onLoadingBlock();
        }
    }
}
- (void)endLoading{
    _state = ATViewStateEnd;
}
- (void)empty{
    _state = ATViewStateEmpty;
}
- (void)error{
    _state = ATViewStateError;
}
- (void)noNetwork{
    _state = ATViewStateNoNetwork;
}

@end
