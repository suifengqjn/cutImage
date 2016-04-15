//
//  BZImageViewController.h
//  imageCut
//
//  Created by qianjianeng on 16/4/15.
//  Copyright © 2016年 SF. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AssetsLibrary/AssetsLibrary.h>


@protocol BZImageCutViewControllerDelegate <NSObject>

- (void)cutImage:(UIImage *)image;

@end

@interface BZImageViewController : UIViewController

//预设两种初始化方法
- (instancetype)initWithALAsset:(ALAsset *)alasset;

- (instancetype)initWithImage:(UIImage *)image;

@property (weak, nonatomic) id <BZImageCutViewControllerDelegate> delegate;

@end
