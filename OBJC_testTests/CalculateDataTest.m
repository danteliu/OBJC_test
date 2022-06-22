//
//  CalculateDataTest.m
//  OBJC_testTests
//
//  Created by liu dante on 2022/6/22.
//

#import <XCTest/XCTest.h>
#import "CalculateData.h"
#import "ManagerNet.h"

@interface CalculateDataTest : XCTestCase
@property (nonatomic, strong) CalculateData * data;/**<  <#属性注释#> */
@end

@implementation CalculateDataTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    CalculateData *data=[[CalculateData alloc] init];
    self.data=data;
}

- (void)tearDown {
    self.data=nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    int result=[self.data a:2 addWithB:4];
    XCTAssert(result==6,@"计算出错");

    
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}
-(void)testA{
    XCTestExpectation *e1=[self expectationWithDescription:@"e1"];
    
    [ManagerNet getRandomColor:({
        NetRequestModel *obj=[[NetRequestModel alloc] init];
        
        obj;
    }) success:^(NetResponseModel * _Nonnull rsp) {
        Log(@"rsp:%@",rsp.mj_keyValues);
        [e1 fulfill];
    } error:^(NSError * _Nonnull error) {
        
    }];
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
