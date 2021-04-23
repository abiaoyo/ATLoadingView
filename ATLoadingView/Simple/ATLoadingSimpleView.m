//
//  ATLoadingSimpleView.m
//  DDLoadingViewDemo
//
//  Created by liyebiao on 2021/4/22.
//  Copyright © 2021 ABiang. All rights reserved.
//

#import "ATLoadingSimpleView.h"
#import "ATLoadingSimpleConfig.h"

@interface ATLoadingSimpleView()
@property (nonatomic,strong) UIActivityIndicatorView * activityView;
@property (nonatomic,strong) UILabel * messageLabel;
@property (nonatomic,strong) UIImageView * imageView;
@end

@implementation ATLoadingSimpleView

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupSubviews];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self addSubview:self.imageView];
    [self addSubview:self.messageLabel];
    [self addSubview:self.activityView];
}

- (void)beginLoading{
    [super beginLoading];
    ATLoadingSimpleConfig * loadingConfig = (ATLoadingSimpleConfig *)self.config.loadingConfig;
    
    self.activityView.frame = loadingConfig.loadingFrame;
    self.messageLabel.frame = loadingConfig.loadingTextFrame;
    self.imageView.alpha = 0.0;
    self.messageLabel.alpha = 1.0;
    self.messageLabel.attributedText = loadingConfig.loadingAttributedText;
    [self.activityView startAnimating];
    
    self.alpha = 1.0f;
    
}

- (void)endLoading{
    [super endLoading];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.imageView.alpha = 0.0;
        self.messageLabel.alpha = 0.0;
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self.activityView stopAnimating];
        [self removeFromSuperview];
    }];
}

- (void)error{
    [super error];
    ATLoadingSimpleConfig * loadingConfig = (ATLoadingSimpleConfig *)self.config.loadingConfig;
    
    self.messageLabel.frame = loadingConfig.errorTextFrame;
    self.imageView.frame = loadingConfig.errorImageFrame;
    self.imageView.image = [UIImage imageNamed:loadingConfig.errorImage];
    self.messageLabel.attributedText = loadingConfig.errorAttributedText;
    [self.activityView stopAnimating];
    self.alpha = 1.0f;
    self.imageView.alpha = 1.0;
    self.messageLabel.alpha = 1.0;
}

- (void)empty{
    [super empty];
    
    ATLoadingSimpleConfig * loadingConfig = (ATLoadingSimpleConfig *)self.config.loadingConfig;
    self.messageLabel.frame = loadingConfig.emptyTextFrame;
    self.imageView.frame = loadingConfig.emptyImageFrame;
    
    self.imageView.image = [UIImage imageNamed:loadingConfig.emptyImage];
    self.messageLabel.attributedText = loadingConfig.emptyAttributedText;
    [self.activityView stopAnimating];
    self.alpha = 1.0f;
    self.imageView.alpha = 1.0;
    self.messageLabel.alpha = 1.0;
}

- (void)noNetwork{
    [super noNetwork];
    
    ATLoadingSimpleConfig * loadingConfig = (ATLoadingSimpleConfig *)self.config.loadingConfig;
    self.messageLabel.frame = loadingConfig.noNetworkTextFrame;
    self.imageView.frame = loadingConfig.noNetworkImageFrame;
    
    self.imageView.image = [UIImage imageNamed:loadingConfig.noNetworkImage];
    self.messageLabel.attributedText = loadingConfig.noNetworkAttributedText;
    [self.activityView stopAnimating];
    self.alpha = 1.0f;
    self.imageView.alpha = 1.0;
    self.messageLabel.alpha = 1.0;
}

//MARK: Getter
- (UIActivityIndicatorView *)activityView{
    if(!_activityView){
        UIActivityIndicatorView * v = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        v.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        v.color = [UIColor grayColor];
        v.hidesWhenStopped = YES;
        v.tag = 2000;
        v.transform = CGAffineTransformScale(v.transform, 0.75, 0.75);
        _activityView = v;
    }
    return _activityView;
}

- (UIImageView *)imageView{
    if(!_imageView){
        UIImageView * v = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 100)];
        v.alpha = 0;
        v.contentMode = UIViewContentModeScaleAspectFit;
        _imageView = v;
    }
    return _imageView;
}

- (UILabel *)messageLabel{
    if(!_messageLabel){
        UILabel * v = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 30)];
        v.textAlignment = NSTextAlignmentCenter;
        v.font = [UIFont systemFontOfSize:14];
        v.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
        v.alpha = 0;
        v.numberOfLines = 0;
        _messageLabel = v;
    }
    return _messageLabel;
}

@end
