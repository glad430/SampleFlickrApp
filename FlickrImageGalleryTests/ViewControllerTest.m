//
//  ViewControllerTest.m
//  FlickrImageGallery
//
//  Created by Abdul  on 19/07/2017.
//  Copyright @ Abdul Mohammed. All rights reserved.
//

#import "RootViewController.h"
#import <XCTest/XCTest.h>


@interface ViewControllerTest : XCTestCase
@property (nonatomic, strong) RootViewController *testController;
@end

@implementation ViewControllerTest
{
    
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.testController = [storyboard instantiateViewControllerWithIdentifier:@"testTableView"];
    [self.testController performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
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

#pragma mark - View loading tests
-(void)testThatViewLoads
{
    XCTAssertNotNil(_testController.view, @"View not initiated properly");
}

- (void)testParentViewHasTableViewSubview
{
    NSArray *subviews = _testController.view.subviews;
    XCTAssertTrue([subviews containsObject:_testController.dataTable], @"View does not have a table subview");
}

-(void)testThatTableViewLoads
{
    XCTAssertNotNil(_testController.dataTable, @"TableView not initiated");
}

#pragma mark - UITableView tests
- (void)testThatViewConformsToUITableViewDataSource
{
    XCTAssertTrue([_testController conformsToProtocol:@protocol(UITableViewDataSource) ], @"View does not conform to UITableView datasource protocol");
}

- (void)testThatTableViewHasDataSource
{
    XCTAssertNotNil(_testController.dataTable.dataSource, @"Table datasource cannot be nil");
}

- (void)testThatViewConformsToUITableViewDelegate
{
    XCTAssertTrue([_testController conformsToProtocol:@protocol(UITableViewDelegate) ], @"View does not conform to UITableView delegate protocol");
}

- (void)testTableViewIsConnectedToDelegate
{
    XCTAssertNotNil(_testController.dataTable.delegate, @"Table delegate cannot be nil");
}

- (void)testTableViewNumberOfRowsInSection
{
    NSInteger expectedRows = 10;
    XCTAssertTrue([_testController tableView:_testController.dataTable numberOfRowsInSection:0]==expectedRows, @"Table has %ld rows but it should have %ld", (long)[_testController tableView:_testController.dataTable numberOfRowsInSection:0], (long)expectedRows);
}

- (void)testTableViewHeightForRowAtIndexPath
{
    CGFloat expectedHeight = 44.0;
    CGFloat actualHeight = _testController.dataTable.rowHeight;
    XCTAssertEqual(expectedHeight, actualHeight, @"Cell should have %f height, but they have %f", expectedHeight, actualHeight);
}

- (void)testTableViewCellCreateCellsWithReuseIdentifier
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell = [_testController tableView:_testController.dataTable cellForRowAtIndexPath:indexPath];
    NSString *expectedReuseIdentifier = [NSString stringWithFormat:@"%ld/%ld",(long)indexPath.section,(long)indexPath.row];
    XCTAssertTrue([cell.reuseIdentifier isEqualToString:expectedReuseIdentifier], @"Table does not create reusable cells");
}

@end
