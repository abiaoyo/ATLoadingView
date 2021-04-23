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

- (void)setConfig:(ATLoadingConfig *)config{
    _config = config;
    self.backgroundColor = config.backgroundColor;
}

- (void)atLoadingBegin{
    if(_state != ATViewStateBegin){
        _state = ATViewStateBegin;
        
        if(self.onBeginBlock){
            self.onBeginBlock();
        }
    }
}
- (void)atLoadingEnd{
    _state = ATViewStateEnd;
}
- (void)atLoadingError{
    _state = ATViewStateError;
}
- (void)atLoadingEmpty{
    _state = ATViewStateEmpty;
}
- (void)atLoadingNoNetwork{
    _state = ATViewStateNoNetwork;
}

@end
