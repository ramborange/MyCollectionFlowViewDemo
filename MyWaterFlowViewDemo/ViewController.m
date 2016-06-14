//
//  ViewController.m
//  MyWaterFlowViewDemo
//
//  Created by ramborange on 16/6/13.
//  Copyright © 2016年 ______MyCompanyName______. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewFlowLayout.h"

#define FILE_PATH   [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"testDic.plist"]

@interface ViewController () <UICollectionViewDelegate,UICollectionViewDataSource,MyWaterFlowDelegate>

@property (nonatomic, strong) UICollectionView *collectionview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MyCollectionViewFlowLayout *collectionViewLayout = [[MyCollectionViewFlowLayout alloc] init];
    collectionViewLayout.degelate = self;
    _collectionview = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:collectionViewLayout];
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    _collectionview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionview];
    
    [_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCellIdentifier"];
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    for (int i=0; i<99; i++) {
        [dic setObject:@(arc4random()%100+100).stringValue forKey:@(i).stringValue];
    }
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    if (![fm fileExistsAtPath:FILE_PATH]){
        BOOL ret = [fm createFileAtPath:FILE_PATH contents:data attributes:nil];
        if (ret) {
            NSLog(@"success save");
        }
    }
    
}

#pragma mark - UIConllectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 99;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"collectionViewCellIdentifier";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:(arc4random()%70)/100.0+0.3];
    
    return cell;
}

#pragma mark - MyCollectionViewFlowLayout WaterFalowView Delegate
- (CGFloat)MyWaterFlow:(MyCollectionViewFlowLayout *)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath {
    NSData *data = [[NSData alloc] initWithContentsOfFile:FILE_PATH];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    return [dic[@(indexPath.item).stringValue] floatValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
