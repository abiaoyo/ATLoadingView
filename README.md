# ATLoadingView
*** cocoapods名字被占用，可以下载代码做本地库 ***

ATLoadingView 用于处理视图加载状态(加载，结束，空，错误，无网络)，便于使用和自定义扩展

```swift

    self.tableView.atView.config.edgeInsets = UIEdgeInsetsMake(10, 10, 5, 5);
    self.tableView.atView.config.viewClass = NSClassFromString(@"ATLoadingSimpleView");
    self.tableView.atView.config.lodingConfigClass = NSClassFromString(@"ATLoadingSimpleConfig");
    self.tableView.atView.config.reLayoutConfigBlock = ^(UIView *superView, ATLoadingView *atLoadingView, id<ATViewLoadingConfigInterface> atLoadingConfig) {
        ATLoadingSimpleConfig * simpleConfig = (ATLoadingSimpleConfig *)atLoadingConfig;

        simpleConfig.noNetworkImage = @"new_public_pics_icon_wifi_un";
        simpleConfig.emptyImage = @"new_pics_no_follow";

        simpleConfig.activityFrame = CGRectMake((superView.bounds.size.width-44)/2.0, (superView.bounds.size.height-44)/2.0, 44, 44);
        simpleConfig.errorImageFrame = CGRectMake((superView.bounds.size.width-100)/2.0, (superView.bounds.size.height-100)/2.0, 100, 100);
        simpleConfig.emptyImageFrame = CGRectMake((superView.bounds.size.width-100)/2.0, (superView.bounds.size.height-100)/2.0, 100, 100);
        simpleConfig.noNetworkImageFrame = CGRectMake((superView.bounds.size.width-100)/2.0, (superView.bounds.size.height-100)/2.0, 100, 100);
        simpleConfig.loadingTextFrame = CGRectMake(0, CGRectGetMaxY(simpleConfig.activityFrame), superView.bounds.size.width, 44);
        simpleConfig.errorTextFrame = CGRectMake(0, CGRectGetMaxY(simpleConfig.errorImageFrame), superView.bounds.size.width, 44);
        simpleConfig.emptyTextFrame = CGRectMake(0, CGRectGetMaxY(simpleConfig.emptyImageFrame), superView.bounds.size.width, 44);
        simpleConfig.noNetworkTextFrame = CGRectMake(0, CGRectGetMaxY(simpleConfig.noNetworkImageFrame), superView.bounds.size.width, 44);
    };
    
    self.tableView.atView.onLoadingBlock = ^{
        NSLog(@"loading..");
        //load data func ..
    };
    
    //begin
    [self.tableView.atView beginLoading];
    
    //end
    [self.tableView.atView endLoading];
    
    //error
    [self.tableView.atView error];
    
    //empty
    [self.tableView.atView empty];
    
    //noNetwork
    [self.tableView.atView noNetwork];

```
