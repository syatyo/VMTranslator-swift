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
        A=D+A
        D=M
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
        A=D+A
        D=M
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
        A=D+A
        D=M
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
        A=D+A
        D=M
        """
        XCTAssertEqual(result, expectation)
    }
    
    
    func testPointerIndexZero() {
        let segment = Pointer(index: 0)
        let result = segment.execute()
        let expectation = """
        @THIS
        D=M
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testPointerIndexOne() {
        let segment = Pointer(index: 1)
        let result = segment.execute()
        let expectation = """
        @THAT
        D=M
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testTempFirst() {
        let segment = Temp(index: 0)
        let result = segment.execute()
        let expectation = """
        @R5
        D=M
        """
        XCTAssertEqual(result, expectation)
    }

    func testTempMiddle() {
        let segment = Temp(index: 4)
        let result = segment.execute()
        let expectation = """
        @R9
        D=M
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testTemp() {
        let segment = Temp(index: 7)
        let result = segment.execute()
        let expectation = """
        @R12
        D=M
        """
        XCTAssertEqual(result, expectation)
    }

    
}
