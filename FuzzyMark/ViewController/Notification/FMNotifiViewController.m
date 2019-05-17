//
//  FMNotifiViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 4/14/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import "FMNotifiViewController.h"
#import "FMNotifiTableViewCell.h"

@interface FMNotifiViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;

@end

@implementation FMNotifiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigationBar];
    [self setTableView];
}

#pragma mark - private
- (void)setNavigationBar {
    self.isHideNavigationBar = NO;
    self.navigationItem.title = @"Thông báo";
    [self addRightButtonNavigationBar];
}

- (void)setTableView {
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    [self.contentTableView registerNib:[UINib nibWithNibName:@"FMNotifiTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (void)addRightButtonNavigationBar {
    UIImage *imgButton = [UIImage imageNamed:@"ic_menu_nv"];
    imgButton = [imgButton imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:imgButton style:UIBarButtonItemStylePlain target:self action:@selector(didSelectRightButton)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)didSelectRightButton {
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMNotifiTableViewCell *cell = [self.contentTableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell binData:@""];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"row: %ld",(long)indexPath.row);
    [self.contentTableView deselectRowAtIndexPath:indexPath animated:YES];
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
