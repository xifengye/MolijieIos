//
//  AddressEditController.m
//  MolijieIos
//
//  Created by yexifeng on 16/6/9.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "AddressEditController.h"
#import "AppDataMemory.h"
#import "AppDataTool.h"
#import "Config.h"
#import "MBProgressHUD+MJ.h"
#import <CoreLocation/CoreLocation.h>
#import "AddressSelectController.h"


@interface AddressEditController()<CLLocationManagerDelegate>{
    NSString* _province ;
    NSString* _city ;
    NSString* _district;
    CLLocationManager *_locationManager;
}
@end

@implementation AddressEditController
-(void)viewDidLoad{
    [super viewDidLoad];
    if(_recipient){
        [self invoke];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"更新" style:UIBarButtonItemStyleDone target:self action:@selector(onSave:)];
    }else{
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(onSave:)];
    }
    [self initializeLocationService];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onPCDSelected:) name:NOTIFYCATION_SELECT_ADDRESS_PCD object:nil];
}


-(void)onSave:(id)sender{
    __block NSString* operate = @"新增";
    if(![self invokeContentValue]){
        [MBProgressHUD showError:@"请填写不完整"];
        return;
    }
    if(_recipient.Number>0){
        operate = @"更新";
        [[AppDataMemory instance] modifyRecipient:_recipient];
    }else{
        _recipient.Number = [self getAddressNumber];
        [[AppDataMemory instance]addRecipient:_recipient];
    }
    [AppDataTool setAddresses:^(BOOL result) {
        if(result){
            [MBProgressHUD showSuccess:[NSString stringWithFormat:@"%@成功!",operate]];
        }else{
            [MBProgressHUD showError:[NSString stringWithFormat:@"%@失败!",operate]];
        }
        [self.navigationController popViewControllerAnimated:YES];
    } onError:^(ErrorCode errorCode) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"%@失败!",operate]];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFYCATION_UPDATE_ADDRESS object:nil];
}



-(void)invoke{
    self.tfName.text = _recipient.RealName;
    self.tfMobile.text = _recipient.Mobile;
    self.tfPhone.text = _recipient.Tel;
    [self.btnPCD setTitle:[_recipient getPCD] forState:UIControlStateNormal];
    self.tfDetail.text = [_recipient getDetail];
    self.tfPostCode.text = _recipient.PostCode;
    self.btnDefault.on = _recipient.AsDefault;
    _province = [_recipient getProvince];
    _city = [_recipient getCity];
    _district = [_recipient getDistrict];
}

-(BOOL)invokeContentValue{
    if(!_recipient){
        self.recipient = [[Recipient alloc]init];
    }
    _recipient.RealName = self.tfName.text;
    _recipient.Mobile = self.tfMobile.text;
    _recipient.Tel = self.tfPhone.text;
    _recipient.PostCode = self.tfPostCode.text;
    [_recipient setPCD:_province city:_city district:_district detail:self.tfDetail.text];
    _recipient.AsDefault = self.btnDefault.on;
    return [_recipient checkSelf];
}

-(NSUInteger) getAddressNumber{
    NSUInteger _id = 0;
    for(Recipient* r in [AppDataMemory instance].recipients){
        if(_id<r.Number){
            _id = r.Number;
        }
    }
    return _id+1;
}

- (IBAction)didLocate:(id)sender {
    // 开始定位
     [_locationManager startUpdatingLocation];
}


- (IBAction)didSelectAddress:(id)sender {
    AddressSelectController *addressVC = [[AddressSelectController alloc]init];
    UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:addressVC];
    [self presentViewController:naVC animated:YES completion:nil];

}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            NSDictionary* elements = placemark.addressDictionary;
            NSString* city = elements[@"City"];
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            [self setPCD:elements[@"State"] city:city district:elements[@"SubLocality"]];
            self.tfDetail.text = [NSString stringWithFormat:@"%@%@",elements[@"Thoroughfare"],elements[@"SubThoroughfare"]];
            
        }
        else if (error == nil && [array count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}

-(void)setPCD:(NSString*)province city:(NSString*)city district:(NSString*)district{
    _province =province;
    _city = city;
    _district = district;
    [_btnPCD setTitle:[NSString stringWithFormat:@"%@%@%@",province,city,district] forState:UIControlStateNormal];
}

-(void)initializeLocationService {
    // 初始化定位管理器
    _locationManager = [[CLLocationManager alloc] init];
    // 设置代理
    _locationManager.delegate = self;
    // 设置定位精确度到米
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    // 设置过滤器为无
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    // 开始定位
    // 取得定位权限，有两个方法，取决于你的定位使用情况
    // 一个是requestAlwaysAuthorization，一个是requestWhenInUseAuthorization
    [_locationManager requestAlwaysAuthorization];//这句话ios8以上版本使用。
   
}

-(void)onPCDSelected:(NSNotification*)notification{
    NSArray* pcd = [notification object];
    [self setPCD:pcd[0] city:pcd[1] district:pcd[2]];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
