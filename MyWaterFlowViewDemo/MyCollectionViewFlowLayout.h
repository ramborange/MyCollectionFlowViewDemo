//
//  CollectionViewFlowLayout.h
//  BSWeather
//
//  Created by ljf on 16/6/7.
//  Copyright © 2016年 BlueSky. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyCollectionViewFlowLayout;
@protocol MyWaterFlowDelegate <NSObject>

-(CGFloat)MyWaterFlow:(MyCollectionViewFlowLayout*)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath*)indexPath;

@end

@interface MyCollectionViewFlowLayout : UICollectionViewLayout
@property (nonatomic, assign) UIEdgeInsets sectionInset;
@property (nonatomic, assign) CGFloat rowMagrin;
@property (nonatomic, assign) CGFloat colMagrin;
@property (nonatomic, assign) CGFloat colCount;
@property (nonatomic, assign) id<MyWaterFlowDelegate> degelate;
@end
