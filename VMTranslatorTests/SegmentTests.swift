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
        D=M
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
        D=M
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
        D=M
        @2
        D=D+A
        """
        XCTAssertEqual(result, expectation)
    }

    func testThat() {
        let segment = That(index: 1)
        let result = segment.execute()
        
        // If that staring pointer is RAM[3000],
        // expectation should point at RAM[3001]
        let expectation = """
        @THAT
        D=M
        @1
        D=D+A
        """
        XCTAssertEqual(result, expectation)
    }
    
    
    func testPointer() {
        let segment = Pointer(index: 2)
        let result = segment.execute()
        let expectation = """
        @3
        D=M
        @2
        D=D+A
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testTemp() {
        let segment = Temp(index: 3)
        let result = segment.execute()
        let expectation = """
        @5
        D=M
        @3
        D=D+A
        """
        XCTAssertEqual(result, expectation)
    }
    
}
