//
//  ViewController.m
//  自定义CollectionViewLayout
//
//  Created by 辛忠志 on 2017/6/14.
//  Copyright © 2017年 辛忠志. All rights reserved.
//

/*******************************获取屏幕的宽高****************************/
#define kSCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define HRXIB(Class) [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([Class class]) owner:nil options:nil] firstObject];

#import "ViewController.h"
#import "CustomCollectionViewCell.h"/*自定义cell*/
#import "CustomUICollectionViewLayout.h"/*自定义布局*/

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *mainCollectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*布局*/
    [self config];
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
}
#pragma mark - ---------- Lazy Loading（懒加载） ----------

#pragma mark - ----------   Lifecycle（生命周期） ----------

#pragma mark - ---------- Private Methods（私有方法） ----------

#pragma mark initliaze data(初始化数据)

#pragma mark config control（布局控件）
-(void)config{
    //自定义UICollectionViewFlowLayout
   UICollectionViewFlowLayout *layout = [[CustomUICollectionViewLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.itemSize = CGSizeMake(200, 200);
    [self.mainCollectionView registerNib:[UINib nibWithNibName:@"CustomCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CustomCollectionViewCell"];
    self.mainCollectionView.backgroundColor = [UIColor whiteColor];
    self.mainCollectionView.showsHorizontalScrollIndicator = NO;
    [self.mainCollectionView setCollectionViewLayout:layout];
}
#pragma mark networkRequest (网络请求)

#pragma mark actions （点击事件）

#pragma mark IBActions （点击事件xib）

#pragma mark - ---------- Public Methods（公有方法） ----------

#pragma mark self declare （本类声明）

#pragma mark override super （重写父类）

#pragma mark setter （重写set方法）

#pragma mark - ---------- Protocol Methods（代理方法） ----------
#pragma mark - ---------- UICollectionViewDelegate ----------
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (collectionView == self.mainCollectionView) {
//        return CGSizeMake(kSCREEN_WIDTH/2-10, 70.0);
//    }
//    else{
//        return  CGSizeMake(0, 0);
//    }
//}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    if (collectionView == self.mainCollectionView) {
//        return UIEdgeInsetsMake(13, 10, 10, 10);
//    }
//    else{
//        return UIEdgeInsetsMake(0, 0, 0, 0);
//    }
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    if (collectionView == self.mainCollectionView) {
//        return 150;
//    }
//    else{
//        return  0;
//    }
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    if (collectionView == self.mainCollectionView) {
//        return 0;
//    }
//    else{
//        return  0;
//    }
//}
//#pragma mark - ---------- UICollectionViewDataSource ----------
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    if (collectionView == self.mainCollectionView) {
//        return 1;
//    }
//    else{
//        return  0;
//    }
//}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;{
    if (collectionView == self.mainCollectionView) {
        return 5;
    }
    else{
        return  0;
    }
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == self.mainCollectionView) {
        CustomCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCollectionViewCell" forIndexPath:indexPath];
        if (cell==nil) {
            cell = HRXIB(CustomCollectionViewCell);
        }
        return cell;
    }
    else{
        return  nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
