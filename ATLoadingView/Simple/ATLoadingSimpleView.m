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

- (void)atLoadingBegin{
    [super atLoadingBegin];
    ATLoadingSimpleConfig * config = (ATLoadingSimpleConfig *)self.config;
    
    self.activityView.frame = config.loadingFrame;
    self.messageLabel.frame = config.loadingTextFrame;
    self.imageView.alpha = 0.0;
    self.messageLabel.alpha = 1.0;
    self.messageLabel.attributedText = config.loadingAttributedText;
    [self.activityView startAnimating];
    
    self.alpha = 1.0f;
    
}

- (void)atLoadingEnd{
    [super atLoadingEnd];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.imageView.alpha = 0.0;
        self.messageLabel.alpha = 0.0;
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self.activityView stopAnimating];
        [self removeFromSuperview];
    }];
}

- (void)atLoadingError{
    [super atLoadingError];
    ATLoadingSimpleConfig * config = (ATLoadingSimpleConfig *)self.config;
    
    self.messageLabel.frame = config.errorTextFrame;
    self.imageView.frame = config.errorImageFrame;
    self.imageView.image = [UIImage imageNamed:config.errorImage];
    self.messageLabel.attributedText = config.errorAttributedText;
    [self.activityView stopAnimating];
    self.alpha = 1.0f;
    self.imageView.alpha = 1.0;
    self.messageLabel.alpha = 1.0;
}

- (void)atLoadingEmpty{
    [super atLoadingEmpty];
    
    ATLoadingSimpleConfig * config = (ATLoadingSimpleConfig *)self.config;
    self.messageLabel.frame = config.emptyTextFrame;
    self.imageView.frame = config.emptyImageFrame;
    
    self.imageView.image = [UIImage imageNamed:config.emptyImage];
    self.messageLabel.attributedText = config.emptyAttributedText;
    [self.activityView stopAnimating];
    self.alpha = 1.0f;
    self.imageView.alpha = 1.0;
    self.messageLabel.alpha = 1.0;
}

- (void)atLoadingNoNetwork{
    [super atLoadingNoNetwork];
    
    ATLoadingSimpleConfig * config = (ATLoadingSimpleConfig *)self.config;
    self.messageLabel.frame = config.noNetworkTextFrame;
    self.imageView.frame = config.noNetworkImageFrame;
    
    self.imageView.image = [UIImage imageNamed:config.noNetworkImage];
    self.messageLabel.attributedText = config.noNetworkAttributedText;
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
