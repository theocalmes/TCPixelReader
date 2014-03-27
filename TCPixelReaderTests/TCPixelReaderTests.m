//
//  TCPixelReaderTests.m
//  TCPixelReaderTests
//
//  Created by Theodore Calmes on 3/21/14.
//  Copyright (c) 2014 theo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreFoundation/CoreFoundation.h>
#import <UIKit/UIKit.h>
#import "TCPixelReader.h"

@interface TCPixelReaderTests : XCTestCase

@property (strong) TCPixelReader *reader;

@end

@implementation TCPixelReaderTests

- (void)setUp
{
    [super setUp];

    self.reader = [TCPixelReader pixelReaderWithImage:[UIImage imageWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"test" ofType:@"png"]]];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPixelAccess
{
    TCPixel p1 = [self.reader pixelForRow:1 column:2];
    XCTAssertTrue(p1.green == 255 && p1.red == 160, @"");

    TCPixel p2 = [self.reader pixelForRow:2 column:6];
    XCTAssertTrue(p2.green == 0 && p2.red == 0 && p2.blue == 0, @"");
}

- (void)testFeatureBounds
{
    CGRect featureBounds = [self.reader featureBoundsForPixelsSatisfyingBlock:^bool(TCPixel pixel) {
        return pixel.red >= 200;
    }];

    XCTAssertTrue(CGRectEqualToRect(featureBounds, CGRectMake(0, 2, 3, 7)), @"");
}

@end
