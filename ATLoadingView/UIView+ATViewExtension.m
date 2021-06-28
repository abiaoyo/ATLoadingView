//
//  UIView+ATViewExtension.m
//  ATLoadingView
//
//  Created by liyebiao on 2021/4/23.
//

#import "UIView+ATViewExtension.h"
#import <objc/runtime.h>
#import "ATLoadingView.h"

@interface ATViewTempDataSourceProxy : NSObject<UITableViewDataSource,UICollectionViewDataSource,UIScrollViewDelegate,UITableViewDelegate,UICollectionViewDelegate>
@property (nonatomic,strong) id oldDataSource;
@property (nonatomic,assign) UITableViewCellSeparatorStyle separatorStyle;
@property (nonatomic,strong) UIView * tableHeaderView;
@property (nonatomic,strong) UIView * tableFooterView;
@property (nonatomic,strong) UIView * mjHeaderView;
@property (nonatomic,strong) UIView * mjFooterView;
@property (nonatomic,assign) BOOL hasSetScrollEnabled;
@property (nonatomic,assign) BOOL originScrollEnabled;
@end

@implementation ATViewTempDataSourceProxy

- (instancetype)init{
    self = [super init];
    if (self) {
        self.separatorStyle = -1;
    }
    return self;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 0;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [UICollectionViewCell new];
}
#pragma mark - UITableViewDelegate/UITableVeiwDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UITableViewCell new];
}
@end





@interface UIView (ATViewExtension_Ext)<ATViewInterface>

@end


@implementation UIView (ATViewExtension)

- (ATViewObject *)atView{
    ATViewObject * obj = objc_getAssociatedObject(self, _cmd);
    if(!obj){
        obj = [[ATViewObject alloc] init];
        obj.ownerView = self;
        [self setAtView:obj];
    }
    return obj;
}
- (void)setAtView:(ATViewObject *)atView{
    objc_setAssociatedObject(self, @selector(atView), atView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ATLoadingView *)atLoadingView{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setAtLoadingView:(ATLoadingView *)atLoadingView{
    objc_setAssociatedObject(self, @selector(atLoadingView), atLoadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (ATViewTempDataSourceProxy *)atViewCurrentDataSourceProxy:(BOOL)createNonExists{
    ATViewTempDataSourceProxy * dataSourceProxy = [self atViewTempDataSourceProxy];
    if (createNonExists && !dataSourceProxy){
        dataSourceProxy = [ATViewTempDataSourceProxy new];
        [self setAtViewTempDataSourceProxy:dataSourceProxy];
    }
    return dataSourceProxy;
}
- (ATViewTempDataSourceProxy *)atViewTempDataSourceProxy{
    ATViewTempDataSourceProxy * dataSourceProx = objc_getAssociatedObject(self, _cmd);
    return dataSourceProx;
}
- (void)setAtViewTempDataSourceProxy:(ATViewTempDataSourceProxy *)atViewTempDataSourceProxy{
    objc_setAssociatedObject(self, @selector(atViewTempDataSourceProxy), atViewTempDataSourceProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



- (BOOL)atLoading_isTableView{
    return [self isKindOfClass:[UITableView class]];
}
- (BOOL)atLoading_isCollectionView{
    return [self isKindOfClass:[UICollectionView class]];
}
- (BOOL)atLoading_isScrollView{
    return [self isKindOfClass:[UIScrollView class]];
}

- (void)atLoading_ClearDataSource{
    if(self.atLoading_isScrollView){
        UIScrollView * scrollView = (UIScrollView *)self;
        ATViewTempDataSourceProxy * dataSourceProxy = [self atViewCurrentDataSourceProxy:NO];
        if(dataSourceProxy){
            dataSourceProxy.hasSetScrollEnabled = NO;
            scrollView.scrollEnabled = dataSourceProxy.originScrollEnabled;
            if(self.atLoading_isTableView){
                UITableView * tableView = (UITableView *)scrollView;
                tableView.dataSource = dataSourceProxy.oldDataSource;
                tableView.separatorStyle = dataSourceProxy.separatorStyle;
                tableView.tableFooterView = dataSourceProxy.tableFooterView;
                tableView.tableHeaderView = dataSourceProxy.tableHeaderView;
                [tableView insertSubview:dataSourceProxy.mjHeaderView atIndex:0];
                [tableView insertSubview:dataSourceProxy.mjFooterView atIndex:0];
                dataSourceProxy.oldDataSource = nil;
                dataSourceProxy.tableFooterView = nil;
                dataSourceProxy.tableHeaderView = nil;
                dataSourceProxy.mjHeaderView = nil;
                dataSourceProxy.mjFooterView = nil;
                dataSourceProxy.separatorStyle = -1;
                [self setAtViewTempDataSourceProxy:nil];
            }else if(self.atLoading_isCollectionView){
                UICollectionView * collectionView = (UICollectionView *)self;
                collectionView.scrollEnabled = dataSourceProxy.originScrollEnabled;
                collectionView.dataSource = dataSourceProxy.oldDataSource;
                [collectionView insertSubview:dataSourceProxy.mjHeaderView atIndex:0];
                [collectionView insertSubview:dataSourceProxy.mjFooterView atIndex:0];
                dataSourceProxy.oldDataSource = nil;
                dataSourceProxy.mjHeaderView = nil;
                dataSourceProxy.mjFooterView = nil;
                [self setAtViewTempDataSourceProxy:nil];
            }
        }
    }
}

//保存tableView or CollectionView 状态
- (void)atLoading_SaveDataSourceWithScrollEnable:(BOOL)scrollEnabled{
    if(self.atLoading_isScrollView){
        UIScrollView * scrollView = (UIScrollView *)self;
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        ATViewTempDataSourceProxy * dataSourceProxy = [self atViewCurrentDataSourceProxy:YES];
        if(!dataSourceProxy.hasSetScrollEnabled){
            dataSourceProxy.hasSetScrollEnabled = YES;
            dataSourceProxy.originScrollEnabled = scrollView.scrollEnabled;
        }
        if(self.atLoading_isTableView){
            UITableView * tableView = (UITableView *)scrollView;
            tableView.scrollEnabled = scrollEnabled;

            UIView * mjHeaderView = dataSourceProxy.mjHeaderView;
            UIView * mjFooterView = dataSourceProxy.mjFooterView;
            if(!mjHeaderView){
                mjHeaderView = [tableView viewWithTag:ATViewForRefreshHeaderTag];
            }
            if(!mjFooterView){
                mjFooterView = [tableView viewWithTag:ATViewForRefreshFooterTag];
            }
            if(!dataSourceProxy.oldDataSource){
                dataSourceProxy.oldDataSource = tableView.dataSource;
            }
            if(!dataSourceProxy.tableHeaderView){
                dataSourceProxy.tableHeaderView = tableView.tableHeaderView;
            }
            if(!dataSourceProxy.tableFooterView){
                dataSourceProxy.tableFooterView = tableView.tableFooterView;
            }
            if(dataSourceProxy.separatorStyle < 0){
                dataSourceProxy.separatorStyle = tableView.separatorStyle;
            }
            dataSourceProxy.mjHeaderView = mjHeaderView;
            dataSourceProxy.mjFooterView = mjFooterView;
            [mjHeaderView removeFromSuperview];
            [mjFooterView removeFromSuperview];
            [tableView.tableHeaderView removeFromSuperview];
            [tableView.tableFooterView removeFromSuperview];
            tableView.dataSource = dataSourceProxy;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            UIView * tHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01f)];
            UIView * tFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01f)];
            tableView.tableHeaderView = tHeaderView;
            tableView.tableFooterView = tFooterView;
            [tableView reloadData];
        }else if(self.atLoading_isCollectionView){
            UICollectionView * collectionView = (UICollectionView *)scrollView;
            collectionView.scrollEnabled = scrollEnabled;
            UIView * mjHeaderView = dataSourceProxy.mjHeaderView;
            UIView * mjFooterView = dataSourceProxy.mjFooterView;
            if(!mjHeaderView){
                mjHeaderView = [collectionView viewWithTag:ATViewForRefreshHeaderTag];
            }
            if(!mjFooterView){
                mjFooterView = [collectionView viewWithTag:ATViewForRefreshFooterTag];
            }
            if(!dataSourceProxy.oldDataSource){
                dataSourceProxy.oldDataSource = collectionView.dataSource;
            }
            
            dataSourceProxy.mjHeaderView = mjHeaderView;
            dataSourceProxy.mjFooterView = mjFooterView;
            [mjHeaderView removeFromSuperview];
            [mjFooterView removeFromSuperview];
            collectionView.dataSource = dataSourceProxy;
            [collectionView reloadData];
        }
        self.atLoadingView.frame = self.atLoading_GetViewFrame;
    }
}

- (CGRect)atLoading_GetViewFrame{
    UIEdgeInsets edge = self.atView.config.edgeInsets;
    CGRect frame = self.bounds;
    frame.origin.x = edge.left;
    frame.origin.y = edge.top;
    frame.size.width = CGRectGetWidth(self.bounds)-edge.left-edge.right;
    frame.size.height = CGRectGetHeight(self.bounds)-edge.top-edge.bottom;
    return frame;
}

- (void)atLoading_CreateView{
    if(!self.atLoadingView){
        ATLoadingView * atLoadingView = nil;
        if(self.atView.config.viewClass){
            atLoadingView = [[self.atView.config.viewClass alloc] initWithFrame:self.atLoading_GetViewFrame];
        }else{
            atLoadingView = [[NSClassFromString(@"ATLoadingSimpleView") alloc] initWithFrame:self.atLoading_GetViewFrame];
        }
        atLoadingView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.atLoadingView = atLoadingView;
        
        
        id<ATViewLoadingConfigInterface> loadingConfig = nil;
        if(self.atView.config.lodingConfigClass){
            loadingConfig = [[self.atView.config.lodingConfigClass alloc] init];
        }else{
            loadingConfig = [[NSClassFromString(@"ATLoadingSimpleConfig") alloc] init];
        }
        self.atView.config.loadingConfig = loadingConfig;
        
            
        if(self.atView.config.reLayoutConfigBlock){
            self.atView.config.reLayoutConfigBlock(self, atLoadingView, loadingConfig);
        }
        atLoadingView.config = self.atView.config;
    }
}

- (void)atLoading_AddView{
    if(!self.atLoadingView.superview){
        [self addSubview:self.atLoadingView];
    }
}

- (void)atLoading_ConfigCallBack{
    __weak typeof(self) weakself = self;
    self.atLoadingView.onLoadingBlock = ^{
        if(weakself.atView.onLoadingBlock){
            weakself.atView.onLoadingBlock();
        }
    };
}

@end


@implementation UIView (ATViewExtension_Ext)

- (void)beginLoading{
    [self beginLoading:YES];
}
- (void)endLoading{
    [self atLoading_ClearDataSource];
    [self.atLoadingView endLoading];
}
- (void)empty{
    [self empty:YES];
}
- (void)error{
    [self error:YES];
}
- (void)noNetwork{
    [self noNetwork:YES];
}

- (void)beginLoading:(BOOL)scrollEnable{
    [self atLoading_CreateView];
    [self atLoading_ConfigCallBack];
    [self atLoading_SaveDataSourceWithScrollEnable:scrollEnable];
    [self atLoading_AddView];
    [self.atLoadingView beginLoading];
    
    if(self.atLoadingView.onLoadingBlock){
        self.atLoadingView.onLoadingBlock();
    }
}
- (void)error:(BOOL)scrollEnable{
    [self atLoading_CreateView];
    [self atLoading_ConfigCallBack];
    [self atLoading_SaveDataSourceWithScrollEnable:scrollEnable];
    [self atLoading_AddView];
    [self.atLoadingView error];
}
- (void)empty:(BOOL)scrollEnable{
    [self atLoading_CreateView];
    [self atLoading_ConfigCallBack];
    [self atLoading_SaveDataSourceWithScrollEnable:scrollEnable];
    [self atLoading_AddView];
    [self.atLoadingView empty];
}
- (void)noNetwork:(BOOL)scrollEnable{
    [self atLoading_CreateView];
    [self atLoading_ConfigCallBack];
    [self atLoading_SaveDataSourceWithScrollEnable:scrollEnable];
    [self atLoading_AddView];
    [self.atLoadingView noNetwork];
}

@end
