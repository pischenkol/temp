//
//  ViewController.m
//  HackathonFacebook
//
//  Created by Lina Pischenko on 03.10.17.
//  Copyright © 2017 PischenkoLina. All rights reserved.
//
#define kScreenWidth            [UIScreen mainScreen].bounds.size.width
#define kScreenHeight           [UIScreen mainScreen].bounds.size.height
#define IS_IPAD                 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_PORTRAIT     UIDeviceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])

#import "ViewController.h"
#import "Masonry.h"

static int kIphoneFieldoffset = 20;
static int kIpadFieldoffset = 60;
static NSString *kLoggin = @"Admin";
static NSString *kPassword = @"Password";

@interface ViewController ()
@property (nonatomic, strong) UIButton *logginButton;
@property (nonatomic, strong) UITextField *logginTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *helpButton;
@property (nonatomic, strong) UIButton *regButton;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIView *separatorView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.27 green:0.41 blue:0.69 alpha:1.00];
    self.logoImageView.image = [UIImage imageNamed:@"facebook-logo"];
    self.logginTextField.placeholder = @"Эл. адрес или телефон";
    self.logginTextField.keyboardType = UIKeyboardTypeEmailAddress;
    self.separatorView.backgroundColor = [UIColor colorWithRed:0.78 green:0.79 blue:0.82 alpha:1.00];
    self.passwordTextField.placeholder = @"Пароль";
    [self.logginButton setTitle:NSLocalizedString(@"Войти", nil)forState:UIControlStateNormal];
    [self.logginButton addTarget:self
                          action:@selector(_logginAction)
                forControlEvents:UIControlEventTouchUpInside];
    [self.regButton addTarget:self
                       action:@selector(_regAction)
             forControlEvents:UIControlEventTouchUpInside];
    [self.helpButton addTarget:self
                        action:@selector(_helpAction)
              forControlEvents:UIControlEventTouchUpInside];
    self.helpButton.titleLabel.textColor = [UIColor whiteColor];
    [self.regButton setTitle:NSLocalizedString(@"Регистрация на Facebook", nil) forState:UIControlStateNormal];
}

#pragma mark - Action

- (void)_logginAction {
    if ([self.logginTextField.text isEqualToString:kLoggin] && [self.passwordTextField.text isEqualToString:kPassword])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                        message:@"you are logged successfully"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Wrong login or password, please try again"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}

- (void)_regAction {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://uk-ua.facebook.com"]];
}

-(void)_helpAction {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://uk-ua.facebook.com/help/"]];
}

#pragma mark - Lazy Load

- (UIImageView*)logoImageView
{
    if (!_logoImageView)
    {
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2-30, kScreenHeight/5, 60, 60)];
        _logoImageView.image = [UIImage imageNamed:@"facebook-logo"];
        _logoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _logoImageView.clipsToBounds = YES;
        [self.view addSubview:_logoImageView];
    }
    return _logoImageView;
}

- (UITextField*)logginTextField
{
    if (!_logginTextField)
    {
        if (IS_IPAD ) {
            _logginTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth/2 - (kScreenWidth/2 -kScreenWidth/10), kScreenHeight/2-kIpadFieldoffset*2, kScreenWidth-(kScreenWidth/10+kScreenWidth/10),kScreenHeight/ 15)];
        }
        else {
        _logginTextField = [[UITextField alloc] initWithFrame:CGRectMake(kIphoneFieldoffset, kScreenHeight/2-kIphoneFieldoffset, kScreenWidth- kIphoneFieldoffset*2,kScreenHeight/ 12)];
        }
        _logginTextField.layer.cornerRadius = 4;
        _logginTextField.font = [UIFont systemFontOfSize:18];
        _logginTextField.backgroundColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00];
        _logginTextField.textColor = [UIColor colorWithRed:0.57 green:0.57 blue:0.57 alpha:1.00];
        [self.view addSubview:_logginTextField];
    }
    return _logginTextField;
}

- (UITextField*)passwordTextField
{
    if (!_passwordTextField)
    {
        _passwordTextField = [UITextField new];
        _passwordTextField.font = [UIFont systemFontOfSize:18];
        _passwordTextField.layer.cornerRadius = 4;
        _passwordTextField.backgroundColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00];
        _passwordTextField.textColor = [UIColor colorWithRed:0.57 green:0.57 blue:0.57 alpha:1.00];
        [self.view addSubview:_passwordTextField];
        
        [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.right.left.equalTo(self.logginTextField);
            make.top.equalTo(self.separatorView.mas_bottom);
        }];
    }
    return _passwordTextField;
}

- (UIView*)separatorView
{
    if (!_separatorView)
    {
        _separatorView = [UIView new];
        [self.view addSubview:_separatorView];
        
        [_separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.right.left.equalTo(self.logginTextField);
            make.top.equalTo(self.logginTextField.mas_bottom);
            make.height.equalTo(@(1));
        }];
    }
    return _separatorView;
}

- (UIButton*)logginButton
{
    if (!_logginButton)
    {
        _logginButton = [UIButton new];
        _logginButton.titleLabel.textColor = [UIColor colorWithRed:0.51 green:0.63 blue:0.80 alpha:1.00];
        _logginButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _logginButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _logginButton.layer.cornerRadius = 4;
        _logginButton.backgroundColor = [UIColor colorWithRed:0.35 green:0.50 blue:0.73 alpha:1.00];
        [self.view addSubview:_logginButton];
        
        [_logginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.right.left.equalTo(self.logginTextField);
            make.top.equalTo(self.passwordTextField.mas_bottom).offset(kIphoneFieldoffset/2);
        }];
    }
    return _logginButton;
}

- (UIButton*)helpButton
{
    if (!_helpButton)
    {
        _helpButton = [UIButton new];
        //[[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/3, kScreenHeight - kScreenHeight/11, kScreenWidth/2, 60)];
        _helpButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _helpButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_helpButton setTitle:NSLocalizedString(@"Нужна помощь?", nil) forState:UIControlStateNormal];
        [self.view addSubview:_helpButton];
        
        [_helpButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.height.equalTo(@(44));
            make.width.equalTo(@(kScreenWidth/2));
            make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        }];
    }
    return _helpButton;
}

- (UIButton*)regButton
{
    if (!_regButton)
    {
        _regButton = [UIButton new];
        _regButton.titleLabel.textColor = [UIColor whiteColor];
        _regButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _regButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self.view addSubview:_regButton];
        
        [_regButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.centerX.equalTo(self.helpButton);
            make.bottom.equalTo(self.helpButton.mas_top).offset(-kIphoneFieldoffset/4);
        }];
    }
    return _regButton;
}

@end
