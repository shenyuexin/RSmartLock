//
//  RAddPersonViewController.m
//  SmartLock
//
//  Created by Richard Shen on 2018/2/5.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RAddPersonViewController.h"
#import "RCustomizeCell.h"
#import "RDatePickerView.h"
#import "RRatePickerView.h"
#import "WBAPIManager+Bussiness.h"

@interface RAddPersonViewController ()

@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) RDatePickerView *pickerView;
@property (nonatomic, strong) RRatePickerView *ratePickerView;
@property (nonatomic, assign) BOOL isEdit;
@end

@implementation RAddPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = _person?@"编辑":@"添加人员";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveClick)];
    
    if(!_person){
        _person = [RPersonInfo new];
        _person.isIcCode = 10;
        _person.isPinCode = 10;
        _person.isFingerprintCode = 10;
    }
    self.tableView.rowHeight = 51;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    self.tableView.separatorColor = HEX_RGB(0xdddddd);
    [self.tableView registerClass:[RCustomizeCell class] forCellReuseIdentifier:RCustomizeCellIdentifier];
    self.dataList = @[@"姓名",@"手机号",@"身份证号",@"有效期",
                      @"密码锁",@"IC卡开锁",@"指纹开锁",@"认证频度"];
    
    @weakify(self);
    RACSignal *endSignal = RACObserve(self.pickerView, endDateString);
    [endSignal  subscribeNext:^(id x) {
        @strongify(self);
        self.person.beginDate = self.pickerView.beginDateString;
        self.person.endDate = self.pickerView.endDateString;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }];
    
    RACSignal *rateSignal = RACObserve(self.ratePickerView, rateMode);
    [rateSignal subscribeNext:^(id x) {
        @strongify(self);
        self.person.rate = self.ratePickerView.rate;
        self.person.rateMode = self.ratePickerView.rateMode;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:7 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }];
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

- (void)setPerson:(RPersonInfo *)person
{
    _person = person;
    _isEdit = YES;
}

#pragma mark - Event
- (void)saveClick
{
    RCustomizeCell *cell0 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    _person.name = cell0.txtField.text;
    if(!_person.name.isNotEmpty){
        [WBLoadingView showErrorStatus:@"姓名不能为空"];
        return;
    }
    if(![_person.name isUserNameContainChinese:2 maxLength:20]){
        [WBLoadingView showErrorStatus:@"姓名不能含有特殊字符"];
        return;
    }
    
    RCustomizeCell *cell1 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    _person.phone = cell1.txtField.text;
    if(!_person.phone.isTelephone){
        [WBLoadingView showErrorStatus:@"请输入11位手机号"];
        return;
    }
    
    RCustomizeCell *cell2 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    _person.idNum = cell2.txtField.text;
    if(!_person.idNum.isIdNum){
        [WBLoadingView showErrorStatus:@"请输入合法身份证号"];
        return;
    }
    
    RCustomizeCell *cell4 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    _person.pwdEnable = cell4.rswitch.isOn;
    
    RCustomizeCell *cell5 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    _person.icEnable = cell5.rswitch.isOn;
    
    RCustomizeCell *cell6 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    _person.fgpEnable = cell6.rswitch.isOn;
    
    if(_isEdit){
        [[WBAPIManager editPerson:_person toLock:_lock.lid] subscribeNext:^(id x) {
            [WBLoadingView showSuccessStatus:@"编辑成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } error:^(NSError *error) {
            [WBLoadingView showErrorStatus:error.domain];
        }];
    }
    else{
        [[WBAPIManager addPerson:_person toLock:_lock.lid] subscribeNext:^(id x) {
            [WBLoadingView showSuccessStatus:@"添加用户成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } error:^(NSError *error) {
            [WBLoadingView showErrorStatus:error.domain];
        }];
    }
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
                cell.txtField.keyboardType = UIKeyboardTypePhonePad;
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
            if(_person.beginDate.isNotEmpty && _person.endDate.isNotEmpty){
                cell.txtField.text = [NSString stringWithFormat:@"%@ 至 %@",_person.beginDate,_person.endDate];
            }
            else{
                cell.txtField.placeholder = @"请输入";
            }
            cell.txtField.frame = CGRectMake(95, 17, SCREEN_WIDTH - 130, 17);
            cell.txtField.enabled = NO;
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
            if(_person.rateString.isNotEmpty){
                cell.txtField.text = _person.rateString;
            }
            else{
                cell.txtField.placeholder = @"请输入";
            }
            cell.txtField.frame = CGRectMake(95, 17, SCREEN_WIDTH - 130, 17);
            cell.txtField.enabled = NO;
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
    if(indexPath.row == 3){
        [self.view endEditing:YES];
        [self.pickerView showInView:[UIApplication sharedApplication].keyWindow];
    }
    else if(indexPath.row == 7){
        [self.view endEditing:YES];
        [self.ratePickerView showInView:[UIApplication sharedApplication].keyWindow];
    }
}

#pragma mark - Getter
- (RDatePickerView *)pickerView
{
    if(!_pickerView){
        _pickerView = [[RDatePickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _pickerView;
}

- (RRatePickerView *)ratePickerView
{
    if(!_ratePickerView){
        _ratePickerView = [[RRatePickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _ratePickerView;
}
@end
