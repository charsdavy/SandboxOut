//
//  ViewController.m
//  Example
//
//  Created by tako on 2022/9/14.
//

#import "ViewController.h"
#import "SandboxOut.h"
#import "SOViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Example";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(16, 100, 180, 42)];
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [button setTitle:@"Default Sandbox" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(lookDefaultSandbox) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *customButton = [[UIButton alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(button.frame) + 6, 180, 42)];
    [customButton setBackgroundColor:[UIColor lightGrayColor]];
    [customButton setTitle:@"Custom Sandbox" forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [customButton addTarget:self action:@selector(lookCustomSandbox) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customButton];
    
    UIButton *create = [[UIButton alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(customButton.frame) + 6, 180, 42)];
    [create setBackgroundColor:[UIColor lightGrayColor]];
    [create setTitle:@"Create temp file" forState:UIControlStateNormal];
    [create setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [create addTarget:self action:@selector(createRandomFile) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:create];
}

- (void)lookDefaultSandbox
{
    SOViewController *viewController = [[SOViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)lookCustomSandbox
{
    SandboxOut *sandboxOut = [[SandboxOut alloc] initWithRootPath:[NSString stringWithFormat:@"%@/Documents", NSHomeDirectory()]];
    SOViewController *viewController = [[SOViewController alloc] init];
    viewController.sandboxOut = sandboxOut;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)createRandomFile
{
    NSString *timestamp = [NSString stringWithFormat:@"%@", [NSDate date]];
    NSString *content = [NSString stringWithFormat:@"%@ - this is test string text", timestamp];
    NSString *rootPath = NSHomeDirectory();
    NSString *path = [rootPath stringByAppendingFormat:@"/Library/%@.txt", timestamp];
    NSError *err = nil;
    [content writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&err];
    if (err) {
        NSLog(@"err: %@", err.description);
    }
}

@end
