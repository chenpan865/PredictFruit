//
//  ViewController.m
//  FruitTestApp
//
//  Created by ChenPan on 2018/6/12.
//  Copyright © 2018 ChenPan. All rights reserved.
//

#import "ViewController.h"
#import "CoreMLModelTest.h"

@interface ViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *rate1;
@property (nonatomic, strong) UILabel *rate2;
@property (nonatomic, strong) UILabel *rate3;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIButton *chooseButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [chooseButton setFrame:CGRectMake(100, 100, 200, 200)];
    chooseButton.backgroundColor = [UIColor whiteColor];
    [chooseButton setTitle:@"push" forState:UIControlStateNormal];
    [self.view addSubview:chooseButton];
    chooseButton.tag = 1004;
    chooseButton.center = self.view.center;//让button位于屏幕中央
    [chooseButton addTarget:self action:@selector(selectImage) forControlEvents:UIControlEventTouchDown];
    
    
    UILabel *fruitName = [[UILabel alloc] init];
    fruitName.frame = CGRectMake(100, 350, 200, 200);
    fruitName.font = [UIFont systemFontOfSize:18.f];
    fruitName.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:fruitName];
    
    self.name = fruitName;
    
    UILabel *rate = [[UILabel alloc] init];
    rate.frame = CGRectMake(100, 380, 200, 200);
    rate.font = [UIFont systemFontOfSize:18.f];
    rate.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:rate];
    
    self.rate1 = rate;
    
    UILabel *rate2 = [[UILabel alloc] init];
    rate2.frame = CGRectMake(100, 410, 200, 200);
    rate2.font = [UIFont systemFontOfSize:18.f];
    rate2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:rate2];
    
    self.rate2 = rate2;
    
    UILabel *rate3 = [[UILabel alloc] init];
    rate3.frame = CGRectMake(100, 440, 200, 200);
    rate3.font = [UIFont systemFontOfSize:18.f];
    rate3.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:rate3];
    
    self.rate3 = rate3;

}

//实现button点击事件的回调方法
- (void)selectImage{
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
    
}


//选择照片完成之后的代理方法

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    NSLog(@"%@",info);
    //刚才已经看了info中的键值对，可以从info中取出一个UIImage对象，将取出的对象赋给按钮的image
    
    UIButton *button = (UIButton *)[self.view viewWithTag:1004];
    
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [button setImage:[resultImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    
    //使用模态返回到软件界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self testModel:resultImage];
}

- (void)testModel:(UIImage*) image
{
    CoreMLModelTest  *test = [[CoreMLModelTest alloc] init];

    [test testWithImage:image completion:^(BOOL isBoss, NSDictionary *dic, NSString *label) {
        self.name.text = label;
        self.rate1.text = [NSString stringWithFormat:@"apple :%lf",[[dic objectForKey:@"apple"] floatValue]];
        self.rate2.text = [NSString stringWithFormat:@"blueBerry :%lf",[[dic objectForKey:@"blueBerry"] floatValue]];
        self.rate3.text = [NSString stringWithFormat:@"strawberry :%lf",[[dic objectForKey:@"strawberry"] floatValue]];
    }];

}


@end
