//
//  UIImage+util.h
//  testCoreML
//
//  Created by ChenPan on 2018/5/23.
//  Copyright © 2018年 ChenPan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (util)

- (UIImage*)createImageWithColor:(CGSize)size;

- (CVPixelBufferRef)pixelBufferFromCGImage:(CGImageRef) image;
- (CVPixelBufferRef)pixelBufferFromCGImage1: (CGImageRef) image;

@end
