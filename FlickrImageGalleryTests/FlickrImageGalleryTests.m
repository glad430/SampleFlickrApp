//
//  FlickrImageGalleryTests.m
//  FlickrImageGalleryTests
//
//  Created by Abdul on 7/18/17.
//  Copyright @ Abdul Mohammed. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WCClasses.h"

@interface FlickrImageGalleryTests : XCTestCase

@end

@implementation FlickrImageGalleryTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.

    }];
}
- (void)testFeedLoading  {
    //XCTAssertNotNil(nil, "data should not be nil");
   // XCTAssertGreaterThan(-1, 0,"data should be greather than 0");
    NSInteger totalCountData = 20;
    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];
    [WCClasses loadFeedByTag:@"" complete:^(NSArray *data){
        XCTAssertNotNil(data, "data should not be nil");
        [expectation fulfill];
        XCTAssertEqual(data.count, totalCountData);
    }fail:^(NSError *error){
        XCTFail(@"Somthing wrong");
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}




@end
