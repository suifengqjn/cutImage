//
//  XCImageCutController.h
//  imageCut
//
//  Created by qianjn on 2017/2/24.
//  Copyright © 2017年 SF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XCImageCutControllerDelegate <NSObject>

- (void)cutImage:(UIImage *)image;

@end

//直接在图片上进行剪切
@interface XCImageCutController : UIViewController
@property (nonatomic, strong) UIImage *currentImage;
@property (nonatomic, assign) id <XCImageCutControllerDelegate> delegate;

@end
