##A demo for iBeacon

###Start a BeaconMonitor

1、 创建一个BeaconRegion，作为搜索的Region对象。其中UUID为Beacon基站的唯一标识。
	
	NSUUID* myUUID = [[NSUUID alloc] initWithUUIDString:@"E621E1F8-C36C-495A-93FC-0C247A3E6E5D"];
    self.targetBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:myUUID identifier:@"My Beacon Demo 20131221"];

2、 创建一个CLLocationManager对象

	self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;

3、 开始搜索Beacon基站

	[self.locationManager startRangingBeaconsInRegion:self.targetBeaconRegion];

接下来可以处理一下回调函数，如：

	- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
	- (void)locationManager:(CLLocationManager *)manager
	 didUpdateLocations:(NSArray *)locations
	- (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLRegion *)region
    - (void)locationManager:(CLLocationManager *)manager
          didExitRegion:(CLRegion *)region
	- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
	
效果图：

![CLProximityImmediate](/images/201312211958.PNG)

![CLProximityNear](/images/201312211959.PNG)

![CLProximityFar](/images/201312212001.PNG)

![CLProximityUnknown](/images/201312212002.PNG)

![didExitRegion](/images/201312212003.PNG)
