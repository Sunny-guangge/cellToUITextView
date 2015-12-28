//
//  CKTableViewController.m
//  textMethod
//
//  Created by user on 15/12/25.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKTableViewController.h"
#import "CKTableViewCell.h"

@interface CKTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CKTableViewController

- (void)viewDidLoad
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1111"];
    
    if (cell == nil) {
        cell = [[CKTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1111"];
    }
    
    [cell.button addTarget:self action:@selector(didclickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)didclickButton:(UIButton *)button
{
    
}

@end
