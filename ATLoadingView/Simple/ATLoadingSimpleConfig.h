//
//  ATLoadingSimpleConfig.h
//  DDLoadingViewDemo
//
//  Created by liyebiao on 2021/4/22.
//  Copyright © 2021 ABiang. All rights reserved.
//

#import "ATLoadingConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface ATLoadingSimpleConfig : ATLoadingConfig

@property (nonatomic,copy) NSAttributedString * errorAttributedText;
@property (nonatomic,copy) NSAttributedString * emptyAttributedText;
@property (nonatomic,copy) NSAttributedString * noNetworkAttributedText;
@property (nonatomic,copy) NSAttributedString * loadingAttributedText;

@property (nonatomic,copy) NSString * errorImage;
@property (nonatomic,copy) NSString * emptyImage;
@property (nonatomic,copy) NSString * noNetworkImage;

@property (nonatomic,assign) CGRect loadingFrame;
@property (nonatomic,assign) CGRect errorImageFrame;
@property (nonatomic,assign) CGRect emptyImageFrame;
@property (nonatomic,assign) CGRect noNetworkImageFrame;

@property (nonatomic,assign) CGRect loadingTextFrame;
@property (nonatomic,assign) CGRect errorTextFrame;
@property (nonatomic,assign) CGRect emptyTextFrame;
@property (nonatomic,assign) CGRect noNetworkTextFrame;

@end

@interface ATLoadingSimpleConfig(Ext)

+ (NSAttributedString *)createAttributedText:(NSString *)text color:(UIColor *)color font:(UIFont *)font;
+ (NSAttributedString *)createDefaultAttributedText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
