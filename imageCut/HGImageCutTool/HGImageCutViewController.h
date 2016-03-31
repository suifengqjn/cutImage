//
//  HGImageCutViewController.h
//  Pinnacle
//
//  Created by qianjianeng on 16/3/30.
//  Copyright © 2016年 The Third Rock Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>


@protocol HGImageCutViewControllerDelegate <NSObject>

- (void)cutImage:(UIImage *)image;

@end

@interface HGImageCutViewController : UIViewController

//预设两种初始化方法
- (instancetype)initWithALAsset:(ALAsset *)alasset;

- (instancetype)initWithImage:(UIImage *)image;

@property (weak, nonatomic) id <HGImageCutViewControllerDelegate> delegate;

@end
