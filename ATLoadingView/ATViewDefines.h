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

typedef NS_ENUM(NSUInteger, ATViewState) {
    ATViewStateIdl = 0,
    ATViewStateBegin,
    ATViewStateEnd,
    ATViewStateError,
    ATViewStateEmpty,
    ATViewStateNoNetwork,
};

@protocol ATLoading <NSObject>
@required
- (void)atLoadingBegin;
- (void)atLoadingEnd;
- (void)atLoadingError;
- (void)atLoadingEmpty;
- (void)atLoadingNoNetwork;

@end


#endif /* ATViewDefines_h */
