//
//  CoreMLModelTest.m
//  testCoreML
//
//  Created by ChenPan on 2018/5/23.
//  Copyright © 2018年 ChenPan. All rights reserved.
//

#import "CoreMLModelTest.h"
@import CoreML;
#import "UIImage+util.h"
#import "FruitClassifier.h"

#import "RACEXTScope.h"
#import "RACmetamacros.h"

@import Vision;


typedef void(^_classificationHandler)(VNRequest * _Nullable request, NSError * _Nullable error);

@implementation CoreMLModelTest

- (void)testWithImage:(UIImage *)image completion:(void (^)(BOOL, NSDictionary *, NSString *))completion
{

    FruitClassifier *model = [[FruitClassifier alloc] init];
    
    UIImage *scaledImage = [image createImageWithColor:CGSizeMake(299, 299)];
    CVPixelBufferRef buffer = [image pixelBufferFromCGImage1:scaledImage.CGImage];
    
    FruitClassifierInput *input = [[FruitClassifierInput alloc] initWithImage:buffer];
    
    MLPredictionOptions *options = [MLPredictionOptions new];
    options.usesCPUOnly = YES;
    NSError *error;
    FruitClassifierOutput *outPut = [model predictionFromFeatures:input error:&error];
    
    completion(YES, outPut.classLabelProbs, outPut.classLabel);
    NSLog(@"classLabelProbs:%@, label: %@" ,outPut.classLabelProbs,outPut.classLabel);
}

@end
