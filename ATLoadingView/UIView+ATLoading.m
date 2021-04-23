//
//  UIView+ATLoading.m
//  DDLoadingViewDemo
//
//  Created by liyebiao on 2021/4/22.
//  Copyright © 2021 ABiang. All rights reserved.
//

#import "UIView+ATLoading.h"
#import <objc/runtime.h>
#import "ATLoadingView.h"

@interface ATLoadingDataSourceProxy : NSObject<UITableViewDataSource,UICollectionViewDataSource,UIScrollViewDelegate,UITableViewDelegate,UICollectionViewDelegate>
@property (nonatomic,strong) id oldDataSource;
@property (nonatomic,assign) UITableViewCellSeparatorStyle separatorStyle;
@property (nonatomic,strong) UIView * tableHeaderView;
@property (nonatomic,strong) UIView * tableFooterView;
@property (nonatomic,strong) UIView * mjHeaderView;
@property (nonatomic,strong) UIView * mjFooterView;

@property (nonatomic,assign) BOOL hasSetScrollEnabled;
@property (nonatomic,assign) BOOL originScrollEnabled;
@end

@implementation ATLoadingDataSourceProxy

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



@implementation UIView (ATLoading)

- (ATLoadingView *)atLoadingView{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setAtLoadingView:(ATLoadingView *)atLoadingView{
    if(atLoadingView != self.atLoadingView){
        objc_setAssociatedObject(self, @selector(atLoadingView), atLoadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}



- (Class  _Nonnull (^)(void))atLoadingViewClass{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setAtLoadingViewClass:(Class  _Nonnull (^)(void))atLoadingViewClass{
    objc_setAssociatedObject(self, @selector(atLoadingViewClass), atLoadingViewClass, OBJC_ASSOCIATION_COPY_NONATOMIC);
}



- (Class  _Nonnull (^)(void))atLoadingConfigClass{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setAtLoadingConfigClass:(Class  _Nonnull (^)(void))atLoadingConfigClass{
    objc_setAssociatedObject(self, @selector(atLoadingConfigClass), atLoadingConfigClass, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (void (^)(UIView * _Nonnull, ATLoadingConfig * _Nonnull))atLoadingConfigModelBlock{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setAtLoadingConfigModelBlock:(void (^)(UIView * _Nonnull, ATLoadingConfig * _Nonnull))atLoadingConfigModelBlock{
    objc_setAssociatedObject(self, @selector(atLoadingConfigModelBlock), atLoadingConfigModelBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}



- (void (^)(void))onAtLoadingBeginBlock{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setOnAtLoadingBeginBlock:(void (^)(void))onAtLoadingBeginBlock{
    objc_setAssociatedObject(self, @selector(onAtLoadingBeginBlock), onAtLoadingBeginBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (ATLoadingDataSourceProxy *)atCurrentDataSourceProxy:(BOOL)createNonExists{
    ATLoadingDataSourceProxy * dataSourceProxy = [self atDataSourceProxy];
    if (createNonExists && !dataSourceProxy){
        dataSourceProxy = [ATLoadingDataSourceProxy new];
        [self setAtDataSourceProxy:dataSourceProxy];
    }
    return dataSourceProxy;
}

- (ATLoadingDataSourceProxy *)atDataSourceProxy{
    ATLoadingDataSourceProxy * dataSourceProx = objc_getAssociatedObject(self, _cmd);
    return dataSourceProx;
}

- (void)setAtDataSourceProxy:(ATLoadingDataSourceProxy *)atDataSourceProxy{
    objc_setAssociatedObject(self, @selector(atDataSourceProxy), atDataSourceProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)atIsTableView{
    return [self isKindOfClass:[UITableView class]];
}

- (BOOL)atIsCollectionView{
    return [self isKindOfClass:[UICollectionView class]];
}

- (BOOL)atIsScrollView{
    return [self isKindOfClass:[UIScrollView class]];
}

- (void)atClearDataSource{
    if(self.atIsScrollView){
        UIScrollView * scrollView = (UIScrollView *)self;
        ATLoadingDataSourceProxy * dataSourceProxy = [self atCurrentDataSourceProxy:NO];
        if(dataSourceProxy){
            dataSourceProxy.hasSetScrollEnabled = NO;
            scrollView.scrollEnabled = dataSourceProxy.originScrollEnabled;
            if(self.atIsTableView){
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
                [self setAtDataSourceProxy:nil];
            }else if(self.atIsCollectionView){
                UICollectionView * collectionView = (UICollectionView *)self;
                ATLoadingDataSourceProxy * dataSourceProxy = [self atDataSourceProxy];
                collectionView.scrollEnabled = dataSourceProxy.originScrollEnabled;
                collectionView.dataSource = dataSourceProxy.oldDataSource;
                
                [collectionView insertSubview:dataSourceProxy.mjHeaderView atIndex:0];
                [collectionView insertSubview:dataSourceProxy.mjFooterView atIndex:0];
                
                dataSourceProxy.oldDataSource = nil;
                dataSourceProxy.mjHeaderView = nil;
                dataSourceProxy.mjFooterView = nil;
                [self setAtDataSourceProxy:nil];
            }
        }
    }
}

//保存tableView or CollectionView 状态
- (void)atSaveDataSourceWithScrollEnable:(BOOL)scrollEnabled{
    if(self.atIsScrollView){
        UIScrollView * scrollView = (UIScrollView *)self;
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        ATLoadingDataSourceProxy * dataSourceProxy = [self atCurrentDataSourceProxy:YES];
        if(!dataSourceProxy.hasSetScrollEnabled){
            dataSourceProxy.hasSetScrollEnabled = YES;
            dataSourceProxy.originScrollEnabled = scrollView.scrollEnabled;
        }
        if(self.atIsTableView){
            UITableView * tableView = (UITableView *)scrollView;
            tableView.scrollEnabled = scrollEnabled;

            UIView * mjHeaderView = dataSourceProxy.mjHeaderView;
            UIView * mjFooterView = dataSourceProxy.mjFooterView;
            if(!mjHeaderView){
                mjHeaderView = [tableView viewWithTag:ATLoadingForRefreshHeaderTag];
            }
            if(!mjFooterView){
                mjFooterView = [tableView viewWithTag:ATLoadingForRefreshFooterTag];
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
        }else if(self.atIsCollectionView){
            UICollectionView * collectionView = (UICollectionView *)scrollView;
            collectionView.scrollEnabled = scrollEnabled;
            
            UIView * mjHeaderView = dataSourceProxy.mjHeaderView;
            UIView * mjFooterView = dataSourceProxy.mjFooterView;
            if(!mjHeaderView){
                mjHeaderView = [collectionView viewWithTag:ATLoadingForRefreshHeaderTag];
            }
            if(!mjFooterView){
                mjFooterView = [collectionView viewWithTag:ATLoadingForRefreshFooterTag];
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
        self.atLoadingView.frame = self.bounds;
    }
}

- (void)atCreateLoadingViewWithNoExist:(BOOL)createNoExist{
    if(!self.atLoadingView){
        if(!createNoExist){
            return;
        }
        ATLoadingView * loadingView = nil;
        if(self.atLoadingViewClass){
            loadingView = [[self.atLoadingViewClass() alloc] initWithFrame:self.bounds];
        }else{
            loadingView = [[NSClassFromString(@"ATLoadingSimpleView") alloc] initWithFrame:self.bounds];
        }
        loadingView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.atLoadingView = loadingView;
        
        ATLoadingConfig * config = nil;
        if(self.atLoadingConfigClass){
            config = [[self.atLoadingConfigClass() alloc] init];
        }else{
            config = [[NSClassFromString(@"ATLoadingSimpleConfig") alloc] init];
        }
        if(self.atLoadingConfigModelBlock){
            self.atLoadingConfigModelBlock(self, config);
        }
        loadingView.config = config;
    }else{
        self.atLoadingView.frame = self.bounds;
    }
}

- (void)atAddLoaingView{
    if(!self.atLoadingView.superview){
        [self addSubview:self.atLoadingView];
    }
}

- (void)atConfigCallback{
    __weak typeof(self) weakself = self;
    self.atLoadingView.onBeginBlock = ^{
        if(weakself.onAtLoadingBeginBlock){
            weakself.onAtLoadingBeginBlock();
        }
    };
}

@end


@implementation UIView (ATLoadingExt)

//MARK:ATLoading
- (void)atLoadingBegin{
    [self atLoadingBegin:YES];
}
- (void)atLoadingEnd{
    [self atClearDataSource];
    [self.atLoadingView atLoadingEnd];
}
- (void)atLoadingError{
    [self atLoadingError:YES];
}
- (void)atLoadingEmpty{
    [self atLoadingEmpty:YES];
}
- (void)atLoadingNoNetwork{
    [self atLoadingNoNetwork:YES];
}

//MARK:----------------
- (void)atLoadingBegin:(BOOL)scrollEnable{
    [self atCreateLoadingViewWithNoExist:YES];
    [self atConfigCallback];
    [self atSaveDataSourceWithScrollEnable:scrollEnable];
    [self atAddLoaingView];
    [self.atLoadingView atLoadingBegin];
    if(self.atLoadingView.onBeginBlock){
        self.atLoadingView.onBeginBlock();
    }
}
- (void)atLoadingError:(BOOL)scrollEnable{
    [self atCreateLoadingViewWithNoExist:YES];
    [self atConfigCallback];
    [self atSaveDataSourceWithScrollEnable:scrollEnable];
    [self atAddLoaingView];
    [self.atLoadingView atLoadingError];
}
- (void)atLoadingEmpty:(BOOL)scrollEnable{
    [self atCreateLoadingViewWithNoExist:YES];
    [self atConfigCallback];
    [self atSaveDataSourceWithScrollEnable:scrollEnable];
    [self atAddLoaingView];
    [self.atLoadingView atLoadingEmpty];
}
- (void)atLoadingNoNetwork:(BOOL)scrollEnable{
    [self atCreateLoadingViewWithNoExist:YES];
    [self atConfigCallback];
    [self atSaveDataSourceWithScrollEnable:scrollEnable];
    [self atAddLoaingView];
    [self.atLoadingView atLoadingNoNetwork];
}

@end
