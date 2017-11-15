//
//  MYTextFieldViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/30.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYTextFieldViewController.h"
#import "MYTextField.h"

@interface MYTextFieldViewController ()<MYTextFieldDelegate>

@property (nonatomic, strong) MYTextField *bankTextField;
@property (nonatomic, strong) MYTextField *phoneTextField;
@property (nonatomic, strong) MYTextField *idCardTextField;

@end

@implementation MYTextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"自定义UITexField";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadTextFieldWithFrame];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneFieldEditingChanged) name:UITextFieldTextDidBeginEditingNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.phoneTextField.textField becomeFirstResponder];
}

- (void)phoneFieldEditingChanged {
    
    
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"DDDDDD");
    return NO;
}

- (void)loadTextFieldWithFrame {
    
    //固定4个进行分隔
    self.bankTextField = [[MYTextField alloc] initWithSeparateCount:4];
    self.bankTextField.frame = CGRectMake(20, 200, 300, 50);
    self.bankTextField.delegate = self;
    self.bankTextField.limitCount = 19;//可以不设置，但是那样的话，就可以无限输入了
    self.bankTextField.layer.cornerRadius = 4.0;
    self.bankTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bankTextField.layer.borderWidth = 2.0;
    
    [self.view addSubview:self.bankTextField];
    
    
    //按照数组中的进行分隔，假如分隔电话号码@[@"3",@"4",@"4"]即可
    self.phoneTextField = [[MYTextField alloc] initWithSeparateArray:@[@"3",@"4",@"4"]];
    self.phoneTextField.frame = CGRectMake(20, 300, 300, 50);
    self.phoneTextField.delegate = self;
    self.phoneTextField.limitCount = 11;//可以不设置，但是那样的话，就可以无限输入了
    self.phoneTextField.layer.cornerRadius = 4.0;
    self.phoneTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.phoneTextField.layer.borderWidth = 2.0;
    
    [self.view addSubview:self.phoneTextField];
    
    
    //输入身份证号
    self.idCardTextField = [[MYTextField alloc] initWithSeparateArray:@[@"6",@"8",@"4"]];
    self.idCardTextField.frame = CGRectMake(20, 400, 300, 50);
    
    self.idCardTextField.delegate = self;
    self.idCardTextField.limitCount = 18;//可以不设置，但是那样的话，就可以无限输入了
    self.idCardTextField.layer.cornerRadius = 4.0;
    self.idCardTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.idCardTextField.layer.borderWidth = 2.0;
    
    [self.view addSubview:self.idCardTextField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
