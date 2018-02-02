//
//  BTCentralManager.h
//  EasyText
//
//  Created by gao feng on 2016/10/21.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import <Foundation/Foundation.h>

#define _Central [BTCentralManager sharedInstance]
#define TRANSFER_SERVICE_UUID           @"E20A39F4-73F5-4BC4-A12F-17D1AD07A960"

@protocol BTCentralManagerDelegate <NSObject>

- (void)onBluetoothOff;
- (void)onScanStarted;
- (void)onPeripheralStateError:(NSString*)err;
- (void)onPeripheralDiscoverd:(NSString*)name;
- (void)onPeripheralConnected:(NSString*)name;
- (void)onPeripheralReceivedText:(NSString*)text;
- (void)onPeripheralReceivedAction:(NSString*)action;
- (void)onPeripheralDisconnected:(NSString*)name;

@end

@interface BTCentralManager : NSObject

@property (nonatomic, weak) id<BTCentralManagerDelegate>     delegate;

+ (instancetype)sharedInstance;

- (void)startScan;

- (void)closeConnection;

- (void)connectToPeripheral:(NSString*)name;

- (void)sendTextToPeripheral:(NSString*)text;

- (NSString*)retrievePreviousServer;
- (void)closePreviousConnection;

@end
