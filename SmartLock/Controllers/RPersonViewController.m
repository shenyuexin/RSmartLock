//
//  RPersonViewController.m
//  SmartLock
//
//  Created by Richard Shen on 2018/2/4.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RPersonViewController.h"
#import "WBSegView.h"
#import "WBSearchBar.h"
#import "UIView+BorderLine.h"
#import "WBOrderViewCell.h"

@interface RPersonViewController ()<WBSegViewDelegate, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) WBSearchBar *searchBar;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) WBSegView *segView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) CGFloat lastOffsetX;
@property (nonatomic, assign) NSInteger lastIndex;
@property (nonatomic, strong) NSMutableDictionary *dataList;

@end

@implementation RPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设定开锁许可人员";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.addBtn];
    
    self.segView.itmes = @[@"当前使用人员(20)",@"历史使用人员(30)"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.segView];
    [self.view addSubview:self.collectionView];
}

- (void)setLock:(RLockInfo *)lock
{
    _lock = lock;
}

#pragma mark - Event
- (void)addClick
{
    [[WBMediator sharedManager] gotoAddPersonController:_lock];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}

#pragma mark - WBSegViewDelegate
- (void)segView:(WBSegView *)segView selectIndex:(NSInteger)index
{
    _lastIndex = index;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_lastIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.segView.itmes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WBOrderViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WBOrderViewCellIdentifier forIndexPath:indexPath];
    cell.index = indexPath.row;
    cell.data = self.dataList;
    return cell;
}


#pragma mark - UIScrollDelegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    *targetContentOffset = scrollView.contentOffset;
    
    NSInteger pageWidth = SCREEN_WIDTH;
    NSInteger width = scrollView.contentOffset.x;
    
    CGFloat cellToSwipe = width%pageWidth*1.0/pageWidth;
    if(_lastOffsetX > width && cellToSwipe <0.7){
        _lastIndex --;
        if(_lastIndex < 0){
            _lastIndex = 0;
        }
    }
    else if(_lastOffsetX < width && cellToSwipe >0.3){
        _lastIndex ++;
        if(_lastIndex > self.segView.itmes.count-1){
            _lastIndex = self.segView.itmes.count-1;
        }
    }
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_lastIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self.segView setSelectIndex:_lastIndex];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    _lastOffsetX = scrollView.contentOffset.x;
}

#pragma mark - Getter
- (UIButton *)addBtn
{
    if(!_addBtn){
        _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        _addBtn.imageEdgeInsets = UIEdgeInsetsMake(13, 26, 13, 0);
        [_addBtn setImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchDown];
    }
    return _addBtn;
}

- (WBSearchBar *)searchBar
{
    if(!_searchBar){
        _searchBar = [[WBSearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 53)];
        _searchBar.placeholder = @"请输入姓名或手机号";
        _searchBar.delegate = self;
        _searchBar.txtFiled.backgroundColor = HEX_RGB(0xf3f3f3);
        _searchBar.backgroundColor = [UIColor whiteColor];
    }
    return _searchBar;
}

- (UIView *)lineView
{
    if(!_lineView){
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 53, SCREEN_WIDTH, PX1)];
        _lineView.backgroundColor = HEX_RGB(0XDDDDDD);
    }
    return _lineView;
}

- (WBSegView *)segView
{
    if(!_segView){
        _segView = [[WBSegView alloc] initWithFrame:CGRectMake(0, 53+PX1, SCREEN_WIDTH, 44-PX1)];
        _segView.backgroundColor = [UIColor whiteColor];
        _segView.delegate = self;
        _segView.selectColor = HEX_RGB(0x3684b5);
        [_segView addBorderLine:BorderTop|BorderBottom];
    }
    return _segView;
}

- (UICollectionView *)collectionView
{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-_segView.bottom);
        layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _segView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-_segView.bottom) collectionViewLayout:layout];
        _collectionView.backgroundColor = RGB(235, 235, 241);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        [_collectionView registerClass:[WBOrderViewCell class] forCellWithReuseIdentifier:WBOrderViewCellIdentifier];
    }
    return _collectionView;
}
@end
