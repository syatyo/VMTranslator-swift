//
//  PushTests.swift
//  VMTranslatorTests
//
//  Created by 山田良治 on 2019/03/03.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class PushTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPushConstant() {
        let push = Push(segment: Constant(), index: 5)
        let result = push.body
        let expectation = """
        @5
        D=A
        @SP
        AM=M+1
        A=A-1
        M=D
        """
        
        XCTAssertEqual(result, expectation)
    }
    
    func testPushLocalZero() {
        let push = Push(segment: Local(), index: 0)
        let result = push.body
        let expectation = """
        @LCL
        D=M
        @0
        A=D+A
        D=M
        @SP
        AM=M+1
        A=A-1
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testPushLocalOne() {
        let push = Push(segment: Local(), index: 1)
        let result = push.body
        let expectation = """
        @LCL
        D=M
        @1
        A=D+A
        D=M
        @SP
        AM=M+1
        A=A-1
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testPushArgumentOne() {
        let push = Push(segment: Argument(), index: 1)
        let result = push.body
        let expectation = """
        @ARG
        D=M
        @1
        A=D+A
        D=M
        @SP
        AM=M+1
        A=A-1
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testThatTwo() {
        let push = Push(segment: That(), index: 2)
        let result = push.body
        let expectation = """
        @THAT
        D=M
        @2
        A=D+A
        D=M
        @SP
        AM=M+1
        A=A-1
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testThisTwo() {
        let push = Push(segment: This(), index: 2)
        let result = push.body
        let expectation = """
        @THIS
        D=M
        @2
        A=D+A
        D=M
        @SP
        AM=M+1
        A=A-1
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testPointerIndexZero() {
        let push = Push(segment: Pointer(), index: 0)
        let result = push.body
        let expectation = """
        @THIS
        D=M
        @SP
        AM=M+1
        A=A-1
        M=D
        """
        XCTAssertEqual(result, expectation)
    }

    func testPointerIndexOne() {
        let push = Push(segment: Pointer(), index: 1)
        let result = push.body
        let expectation = """
        @THAT
        D=M
        @SP
        AM=M+1
        A=A-1
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testTempFirst() {
        let push = Push(segment: Temp(), index: 0)
        let result = push.body
        let expectation = """
        @R5
        D=M
        @SP
        AM=M+1
        A=A-1
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testTempMiddle() {
        let push = Push(segment: Temp(), index: 4)
        let result = push.body
        let expectation = """
        @R9
        D=M
        @SP
        AM=M+1
        A=A-1
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testTempLast() {
        let push = Push(segment: Temp(), index: 7)
        let result = push.body
        let expectation = """
        @R12
        D=M
        @SP
        AM=M+1
        A=A-1
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testStatic() {
        let push = Push(segment: Static(fileName: "ABC.vm"), index: 7)
        let result = push.body
        let expectation = """
        @ABC.7
        D=M
        @SP
        AM=M+1
        A=A-1
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
}
