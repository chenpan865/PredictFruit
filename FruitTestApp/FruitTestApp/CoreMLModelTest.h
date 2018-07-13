//
//  CoreMLModelTest.h
//  testCoreML
//
//  Created by ChenPan on 2018/5/23.
//  Copyright © 2018年 ChenPan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CoreMLModelTest : NSObject

- (void)testWithImage:(UIImage*)image completion:(void (^)(BOOL isBoss, NSDictionary *dic ,NSString * label))completion;

@end
