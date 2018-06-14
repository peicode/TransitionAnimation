//
//  ViewController.m
//  自定义转场动画
//
//  Created by sunny&pei on 2018/6/11.
//  Copyright © 2018年 sunny&pei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,copy)NSArray *data;
@property(nonatomic,copy)NSArray *viewsController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自定义转场动画";
    self.navigationController.view.layer.cornerRadius = 12.0f;
    self.navigationController.view.layer.masksToBounds = YES;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
}

-(NSArray *)data{
    if (_data == nil) {
        _data = [@[@"弹性POP",@"圆点扩散"] copy];
    }
    return _data;
}
-(NSArray *)viewsController{
    if (!_viewsController) {
        _viewsController = [@[@"PSPresentOneController",@"PSCircleSpreadController"] copy];
    }
    return _viewsController;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _data[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[[NSClassFromString(self.viewsController[indexPath.row]) alloc]init] animated:YES];
}

@end
