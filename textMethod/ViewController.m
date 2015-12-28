//
//  ViewController.m
//  textMethod
//
//  Created by user on 15/12/11.
//  Copyright © 2015年 user. All rights reserved.
//

#import "ViewController.h"
#import "CKTableViewCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UITableView *comTableView;

@property (nonatomic,strong) UITextField *textField;

@end

@implementation ViewController
{
    CGFloat replyViewDraw;
    BOOL scrolling;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didKeyboardChange:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didKeyboardhide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.view addSubview:self.comTableView];
    
    [self.view addSubview:self.textField];
    
    scrolling = NO;
}

#pragma mark - UIKeyboardWillHideNotification & UIKeyboardWillShowNotification
- (void)didKeyboardhide:(NSNotification *)noti
{
    NSDictionary *dic = noti.userInfo;
    
    //获取键盘的动画时间
    NSNumber *duration = [dic objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    [UIView animateWithDuration:[duration doubleValue] animations:^{
        self.textField.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 40);
        
    }];
}

- (void)didKeyboardChange:(NSNotification *)noti
{
    NSDictionary *dic = noti.userInfo;
    
    CGRect rect = [[dic objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    CGSize size = rect.size;
    
    scrolling = YES;
    
    //获取键盘的动画时间
    NSNumber *duration = [dic objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    //获取键盘的动画方式
//    NSNumber *curve = [dic objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    
    [UIView animateWithDuration:[duration doubleValue] animations:^{
        
        self.textField.frame = CGRectMake(0, self.view.frame.size.height - size.height - 40, self.view.frame.size.width, 40);
        
        CGPoint point = self.comTableView.contentOffset;
        
        point.y -= (self.textField.frame.origin.y - replyViewDraw);
        
        if (point.y < 0) {
            
        }else
        {
            self.comTableView.contentOffset = point;
        }
        
        
    } completion:^(BOOL finished) {
        
        scrolling = NO;
        
    }];
    
}

#pragma mark - Getter
- (UITextField *)textField
{
    if (_textField == nil) {
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 40)];
        _textField.placeholder = @"输入内容";
        _textField.backgroundColor = [UIColor whiteColor];
    }
    return _textField;
}

- (UITableView *)comTableView
{
    if (_comTableView == nil) {
        _comTableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _comTableView.delegate = self;
        _comTableView.dataSource = self;
    }
    return _comTableView;
}


#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"111"];
    
    if (cell == nil) {
        cell = [[CKTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"111"];
    }
    
    [cell.button addTarget:self action:@selector(didCLickCellButton:) forControlEvents:UIControlEventTouchUpInside];
    cell.button.tag = indexPath.row;
    
    return cell;
}

- (void)didCLickCellButton:(UIButton *)button
{
    if ([self.textField isFirstResponder]) {
        
    }else
    {
        
        CKTableViewCell *cell = (CKTableViewCell *) button.superview;
        cell.backgroundColor = [UIColor redColor];
        replyViewDraw = [cell convertRect:cell.bounds toView:self.view.window].origin.y + cell.frame.size.height;
        [self.textField becomeFirstResponder];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([self.textField isFirstResponder]) {
        
        [self.textField resignFirstResponder];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UISCrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.textField isFirstResponder]) {
        
        if (scrolling) {
            
        }else
        {
            [self.textField resignFirstResponder];
        }
        
    }else
    {
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
