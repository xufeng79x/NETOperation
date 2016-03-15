//
//  ViewController.m
//  NetOperation
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "NSMutableURLRequest+Multipart.h"

@interface ViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGSize boundRectSize = [self.view bounds].size;

    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, boundRectSize.width, boundRectSize.height/2)];
    
    [self.view addSubview:self.imageView];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //[self downloadFile];
    //[self getLogin];
    //[self postLogin];
    [self postUpLoadFile];
}


-(void)downloadFile
{
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperationWithBlock:^{
        //step_1:创建URL
        NSString *urlStr = @"http://imgsrc.baidu.com/forum/pic/item/645b8701a18b87d6e716e197070828381e30fdae.jpg";
        NSURL *url = [NSURL URLWithString:urlStr];
        
        //step_2:创建request
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:2.0f];
        
        //step_3:建立连接接受返回数据
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            // 反序列化
            UIImage *image = [[UIImage alloc]initWithData:data];
            
            // 设定UI显示
            self.imageView.image = image;
        }];

    }];
}


/**POST*/
- (void)postLogin
{
    
    // step_1:创建URL
    NSString *urlString = @"http://127.0.0.1/login.php";
    NSURL *url = [NSURL URLWithString:urlString];
    
    // step_2:创建request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:2.0f];
    
    // 2.1 指定http的访问方法，服务器短才知道如何访问
    request.HTTPMethod = @"POST";
    
    // 2.2 指定数据体，数据体的内容可以从firebug里面直接拷贝
    NSString *username = @"xf";
    NSString *pwd = @"ios";
    NSString *bobyStr = [NSString stringWithFormat:@"username=%@&password=%@", username, pwd];
    
    // 2.2.1 跟服务器的交互，全部传递的二进制
    request.HTTPBody = [bobyStr dataUsingEncoding:NSUTF8StringEncoding];
    
    // step_3:建立连接接受返回数据
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        // 反序列化
        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        NSLog(@"%@", result);
    }];
    
}


- (void)getLogin
{
    
    // step_1:创建URL
    NSString *username = @"xf";
    NSString *pwd = @"ios";
    NSString *urlString = [NSString stringWithFormat:@"http://127.0.0.1/login.php?username=%@&password=%@",username, pwd];
    NSURL *url = [NSURL URLWithString:urlString];
    
    
    // step_2:创建request
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:2.0f];
    
    // step_3:建立连接接受返回数据
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        // 反序列化
        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        NSLog(@"%@", result);
    }];
}


- (void)postUpLoadFile {
    
    // 1. 创建URL
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/post/upload.php"];
    
    // 2. 创建request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url andLoaclFilePath:[[NSBundle mainBundle] pathForResource:@"test.png" ofType:nil] andFileName:@"test.png"];
    
    
    // 3. 建立连接接受返回数据
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        // 4. 反序列化数据
        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        NSLog(@"result = %@", result);
    }];
}

@end
