//
//  SocketTestDemo.m
//  UTestTemplateTests
//
//  Created by hansong on 11/6/20.
//

#import <XCTest/XCTest.h>

#import "SocketDemo.h"
@interface SocketTestDemo : XCTestCase

@end

@implementation SocketTestDemo
- (void)testSettingConfig{
    
}
- (void)testManagerProperties{
//    XCTAssertNotNil([SocketDemo shared].manager.defaultSocket);
//    XCTAssertNil([SocketDemo shared].manager.engine);
//    XCTAssertFalse(self.manager.forceNew);
//    XCTAssertEqual(self.manager.handleQueue, dispatch_get_main_queue());
//    XCTAssertTrue(self.manager.reconnects);
//    XCTAssertEqual(self.manager.reconnectWait, 10);
//    XCTAssertEqual(self.manager.reconnectWaitMax, 30);
//    XCTAssertEqual(self.manager.randomizationFactor, 0.5);
//    XCTAssertEqual(self.manager.status, SocketIOStatusNotConnected);
}
- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
