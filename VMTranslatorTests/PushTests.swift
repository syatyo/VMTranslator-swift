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
        let push = Push(segment: .constant, index: 5)
        let result = push.execute()
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
        let push = Push(segment: .local, index: 0)
        let result = push.execute()
        let expectation = """
        @LCL
        D=A
        @0
        D=D+A
        @SP
        AM=M+1
        A=A-1
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testPushLocalOne() {
        let push = Push(segment: .local, index: 1)
        let result = push.execute()
        let expectation = """
        @LCL
        D=A
        @1
        D=D+A
        @SP
        AM=M+1
        A=A-1
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testPushArgumentOne() {
        let push = Push(segment: .argument, index: 1)
        let result = push.execute()
        let expectation = """
        @ARG
        D=A
        @1
        D=D+A
        @SP
        AM=M+1
        A=A-1
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testThatTwo() {
        let push = Push(segment: .that, index: 2)
        let result = push.execute()
        let expectation = """
        @THAT
        D=A
        @2
        D=D+A
        @SP
        AM=M+1
        A=A-1
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testThisTwo() {
        let push = Push(segment: .this, index: 2)
        let result = push.execute()
        let expectation = """
        @THIS
        D=A
        @2
        D=D+A
        @SP
        AM=M+1
        A=A-1
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testPointer() {
        let push = Push(segment: .pointer, index: 2)
        let result = push.execute()
        let expectation = """
        @3
        D=A
        @2
        D=D+A
        @SP
        AM=M+1
        A=A-1
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testTemp() {
        let push = Push(segment: .temp, index: 4)
        let result = push.execute()
        let expectation = """
        @5
        D=A
        @4
        D=D+A
        @SP
        AM=M+1
        A=A-1
        M=D
        """
        XCTAssertEqual(result, expectation)

    }
}
