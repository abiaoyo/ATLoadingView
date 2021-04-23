//
//  ViewController.m
//  ATLoadingView
//
//  Created by liyebiao on 2021/4/22.
//

#import "ViewController.h"
#import "UIView+ATViewExtension.h"
#import "ATLoadingSimpleConfig.h"

#import <MJRefresh/MJRefreshNormalHeader.h>
#import <MJRefresh/MJRefreshAutoNormalFooter.h>
#import <MJRefresh/MJRefreshBackNormalFooter.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)endRefreshing{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCell"];
    
    /**
     
     //self.tableView.atView.config.edgeInsets = (10,20,10,30);
     //self.tableView.atView.config.viewClass = NSClassFromString(@"ATLoadingSimpleView");
     //self.tableView.atView.config.lodingConfigClass = NSClassFromString(@"ATLoadingSimpleConfig");
     //self.tableView.atView.config.reLayoutConfigBlock = ^(UIView * superView, UIView * atView, ATViewLoadingConfig * loadingConfig){
     //
     //};
     //self.tableView.atView.onLoadingBlock = ^{
     //
     //};
     //
     //[self.tableView.atView beginLoading];
     //[self.tableView.atView endLoading];
     //[self.tableView.atView empty];
     //[self.tableView.atView error];
     //[self.tableView.atView noNetwork];
     */
    
    __weak typeof(self) weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself performSelector:@selector(endRefreshing) withObject:nil afterDelay:3];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself performSelector:@selector(endRefreshing) withObject:nil afterDelay:3];
    }];
    
    self.tableView.mj_header.tag = ATViewForRefreshHeaderTag;
    self.tableView.mj_footer.tag = ATViewForRefreshFooterTag;

    self.tableView.atView.config.edgeInsets = UIEdgeInsetsMake(10, 10, 5, 5);
//    self.tableView.atView.config.viewClass = NSClassFromString(@"ATLoadingSimpleView");
//    self.tableView.atView.config.lodingConfigClass = NSClassFromString(@"ATLoadingSimpleConfig");
    self.tableView.atView.config.reLayoutConfigBlock = ^(UIView *superView, UIView *atView, id<ATViewLoadingConfigInterface> loadingConfig) {
        ATLoadingSimpleConfig * simpleConfig = (ATLoadingSimpleConfig *)loadingConfig;

        simpleConfig.noNetworkImage = @"new_public_pics_icon_wifi_un";
        simpleConfig.emptyImage = @"new_pics_no_follow";

        simpleConfig.loadingFrame = CGRectMake((superView.bounds.size.width-44)/2.0, (superView.bounds.size.height-44)/2.0, 44, 44);
        simpleConfig.errorImageFrame = CGRectMake((superView.bounds.size.width-100)/2.0, (superView.bounds.size.height-100)/2.0, 100, 100);
        simpleConfig.emptyImageFrame = CGRectMake((superView.bounds.size.width-100)/2.0, (superView.bounds.size.height-100)/2.0, 100, 100);
        simpleConfig.noNetworkImageFrame = CGRectMake((superView.bounds.size.width-100)/2.0, (superView.bounds.size.height-100)/2.0, 100, 100);
        simpleConfig.loadingTextFrame = CGRectMake(0, CGRectGetMaxY(simpleConfig.loadingFrame), superView.bounds.size.width, 44);
        simpleConfig.errorTextFrame = CGRectMake(0, CGRectGetMaxY(simpleConfig.errorImageFrame), superView.bounds.size.width, 44);
        simpleConfig.emptyTextFrame = CGRectMake(0, CGRectGetMaxY(simpleConfig.emptyImageFrame), superView.bounds.size.width, 44);
        simpleConfig.noNetworkTextFrame = CGRectMake(0, CGRectGetMaxY(simpleConfig.noNetworkImageFrame), superView.bounds.size.width, 44);
    };
    
    self.tableView.atView.onLoadingBlock = ^{
        NSLog(@"开始加载数据..");
    };
}
- (IBAction)clickBegin:(id)sender {
    [self.tableView.atView beginLoading];
}
- (IBAction)clickEnd:(id)sender {
    [self.tableView.atView endLoading];
}
- (IBAction)clickError:(id)sender {
    [self.tableView.atView error];
}
- (IBAction)clickEmpty:(id)sender {
    [self.tableView.atView empty];
}
- (IBAction)clickNoNetwork:(id)sender {
    [self.tableView.atView noNetwork];
}

#pragma mark - UITableViewDelegate/UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"UITableViewCell %@",@(indexPath.row)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
