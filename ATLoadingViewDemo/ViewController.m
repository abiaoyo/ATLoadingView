//
//  ViewController.m
//  ATLoadingView
//
//  Created by liyebiao on 2021/4/22.
//

#import "ViewController.h"
#import "UIView+ATLoading.h"
#import "ATLoadingSimpleConfig.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCell"];
    
    self.tableView.atLoadingViewClass = ^Class _Nonnull{
        return NSClassFromString(@"ATLoadingSimpleView");
    };
    self.tableView.atLoadingConfigClass = ^Class _Nonnull{
        return NSClassFromString(@"ATLoadingSimpleConfig");
    };
    self.tableView.atLoadingConfigModelBlock = ^(UIView * _Nonnull superView, ATLoadingConfig * _Nonnull config) {
        ATLoadingSimpleConfig * simpleConfig = (ATLoadingSimpleConfig *)config;
        
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
    self.tableView.onAtLoadingBeginBlock = ^{
        NSLog(@"开始加载..");
    };
}
- (IBAction)clickBegin:(id)sender {
    [self.tableView atLoadingBegin];
}
- (IBAction)clickEnd:(id)sender {
    [self.tableView atLoadingEnd];
}
- (IBAction)clickError:(id)sender {
    [self.tableView atLoadingError];
}
- (IBAction)clickEmpty:(id)sender {
    [self.tableView atLoadingEmpty];
}
- (IBAction)clickNoNetwork:(id)sender {
    [self.tableView atLoadingNoNetwork];
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
