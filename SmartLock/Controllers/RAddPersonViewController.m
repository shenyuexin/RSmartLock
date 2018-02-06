//
//  RAddPersonViewController.m
//  SmartLock
//
//  Created by Richard Shen on 2018/2/5.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RAddPersonViewController.h"
#import "RCustomizeCell.h"
#import "RPersonInfo.h"

@interface RAddPersonViewController ()

@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) RPersonInfo *person;
@end

@implementation RAddPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"添加人员";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveClick)];
    
    self.tableView.rowHeight = 51;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    self.tableView.separatorColor = HEX_RGB(0xdddddd);
    [self.tableView registerClass:[RCustomizeCell class] forCellReuseIdentifier:RCustomizeCellIdentifier];
    self.dataList = @[@"姓名",@"手机号",@"身份证号",@"有效期",
                      @"密码锁",@"IC卡开锁",@"指纹开锁",@"认证频度"];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event
- (void)saveClick
{
    
    RCustomizeCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    _person.pwdEnable = cell.rswitch.isOn;
    RCustomizeCell *cell1 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    _person.icEnable = cell1.rswitch.isOn;
    RCustomizeCell *cell2 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    _person.fgpEnable = cell2.rswitch.isOn;
}

#pragma mark - UITableView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RCustomizeCell *cell = [tableView dequeueReusableCellWithIdentifier:RCustomizeCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    switch (indexPath.row) {
        case 0:
        {
            if(_person.name.isNotEmpty){
                cell.txtField.text = _person.name;
            }
            else{
                cell.txtField.placeholder = @"请输入";
            }
            break;
        }
        case 1:
        {
            if(_person.phone.isNotEmpty){
                cell.txtField.text = _person.phone;
            }
            else{
                cell.txtField.placeholder = @"请输入";
            }
            break;
        }
        case 2:
        {
            if(_person.idNum.isNotEmpty){
                cell.txtField.text = _person.idNum;
            }
            else{
                cell.txtField.placeholder = @"请输入";
            }
            break;
        }
        case 3:
        {
            if(_person.beginDate >0 && _person.endDate >0){
                cell.txtField.text = _person.validDate;
            }
            else{
                cell.txtField.placeholder = @"请输入";
            }
            cell.txtField.width = SCREEN_WIDTH - 150;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        case 4:
        {
            cell.rswitch.on = _person.pwdEnable;
            break;
        }
        case 5:
        {
            cell.rswitch.on = _person.icEnable;
            break;
        }
        case 6:
        {
            cell.rswitch.on = _person.fgpEnable;
            break;
        }
        case 7:
        {
            if(_person.rate > 0){
                cell.txtField.text = @"一周一次";
            }
            else{
                cell.txtField.placeholder = @"请输入";
            }
            cell.txtField.width = SCREEN_WIDTH - 150;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        default:
            break;
    }
    cell.titleLabel.text = self.dataList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
}
@end
