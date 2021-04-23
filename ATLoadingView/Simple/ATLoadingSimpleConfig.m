//
//  ATLoadingSimpleConfig.m
//  DDLoadingViewDemo
//
//  Created by liyebiao on 2021/4/22.
//  Copyright © 2021 ABiang. All rights reserved.
//

#import "ATLoadingSimpleConfig.h"

@implementation ATLoadingSimpleConfig

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor orangeColor];
        
        self.emptyAttributedText = [self.class createDefaultAttributedText:@"empty"];
        self.errorAttributedText = [self.class createDefaultAttributedText:@"error"];
        self.noNetworkAttributedText = [self.class createDefaultAttributedText:@"no network"];
        
        self.emptyImage = @"ATLoadingView.bundle/page_empty_def.png";
        self.errorImage = @"ATLoadingView.bundle/page_empty_def.png";
        self.noNetworkImage = @"ATLoadingView.bundle/page_empty_def.png";
        
        self.errorImageFrame = CGRectMake(0,0,90,90);
        self.emptyImageFrame = self.errorImageFrame;
        self.noNetworkImageFrame = self.errorImageFrame;
    }
    return self;
}

@end

@implementation ATLoadingSimpleConfig(Ext)

+ (NSAttributedString *)createAttributedText:(NSString *)text color:(UIColor *)color font:(UIFont *)font{
    NSMutableAttributedString * attributed = [[NSMutableAttributedString alloc] initWithString:text];
    [attributed addAttribute:NSFontAttributeName
                       value:font
                       range:NSMakeRange(0, text.length)];
    [attributed addAttribute:NSForegroundColorAttributeName
                       value:color
                       range:NSMakeRange(0, text.length)];
    return attributed;
}

+ (NSAttributedString *)createDefaultAttributedText:(NSString *)text{
    UIColor * defColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
    UIFont * defFont = [UIFont systemFontOfSize:14];
    return [self createAttributedText:text color:defColor font:defFont];
}

@end
