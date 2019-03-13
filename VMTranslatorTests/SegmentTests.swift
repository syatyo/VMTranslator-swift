//
//  SegmentTests.swift
//  VMTranslatorTests
//
//  Created by 山田良治 on 2019/03/13.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class SegmentTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLocal() {
        let segment = Local(index: 5)
        let result = segment.execute()
        let expectation = """
        @LCL
        D=A
        @5
        D=D+A
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testArgument() {
        let segment = Argument(index: 2)
        let result = segment.execute()
        let expectation = """
        @ARG
        D=A
        @2
        D=D+A
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testThis() {
        let segment = This(index: 2)
        let result = segment.execute()
        let expectation = """
        @THIS
        D=A
        @2
        D=D+A
        """
        XCTAssertEqual(result, expectation)
    }

    func testThat() {
        let segment = That(index: 1)
        let result = segment.execute()
        let expectation = """
        @THAT
        D=A
        @1
        D=D+A
        """
        XCTAssertEqual(result, expectation)
    }
    
}
