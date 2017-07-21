//
//  RootViewTest.m
//  FlickrImageGallery
//
//  Created by Abdul  on 21/07/2017.
//  Copyright © 2017 Creative Infoway. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RootViewController.h"
#import "UIMockActionSheet.h"
#import "UIMockActionSheetVerifier.h"

@interface RootViewTest : XCTestCase
@property (nonatomic, strong) RootViewController *testController;
@end

@implementation RootViewTest

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.testController = [storyboard instantiateViewControllerWithIdentifier:@"testTableView"];
        [self.testController performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
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


- (void)testShowActionSheet
{
    _testController.actionSheetClass = [UIMockActionSheet class];
    UIMockActionSheetVerifier *sheetVerifier = [[UIMockActionSheetVerifier alloc] init];

    [_testController sortBtnClicked:nil];

    XCTAssertEqual(sheetVerifier.showCount, 1);
    XCTAssertEqual(sheetVerifier.parentView, [_testController view]);
    XCTAssertEqualObjects(sheetVerifier.title, @"Sorting by");
    XCTAssertEqual(sheetVerifier.delegate, _testController);
    XCTAssertEqualObjects(sheetVerifier.cancelButtonTitle, @"Cancel");
    NSArray *otherButtonTitles = sheetVerifier.otherButtonTitles;
    XCTAssertEqual([otherButtonTitles count], 4);
    XCTAssertEqualObjects(otherButtonTitles[0], @"Order by date taken ascending");
    XCTAssertEqualObjects(otherButtonTitles[1], @"Order by date taken descending");
    XCTAssertEqualObjects(otherButtonTitles[2], @"Order by publish ascending");
    XCTAssertEqualObjects(otherButtonTitles[3], @"Order by publish descending");
}


@end
