//
//  XCImageCutScrollow.h
//  imageCut
//
//  Created by qianjn on 2017/2/24.
//  Copyright © 2017年 SF. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kNavHeight 64
@interface XCImageCutScrollow : UIScrollView
@property (nonatomic, strong, readonly) UIImageView *imageView;
- (instancetype)initWithImage:(UIImage *)image;
@end
