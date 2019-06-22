//
//  WorkingStackTests.swift
//  VMTranslatorTests
//
//  Created by 山田良治 on 2019/06/23.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class WorkingStackTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPushConstant() {
        var stack = WorkingStack()
        stack.push(segment: Constant(), index: 5)
        let result = stack.body
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
        var stack = WorkingStack()
        stack.push(segment: Local(), index: 0)
        let result = stack.body
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
        var stack = WorkingStack()
        stack.push(segment: Local(), index: 1)
        let result = stack.body
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
        var stack = WorkingStack()
        stack.push(segment: Argument(), index: 1)
        let result = stack.body
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
    
    func testPushThatTwo() {
        var stack = WorkingStack()
        stack.push(segment: That(), index: 2)
        let result = stack.body
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
    
    func testPushThisTwo() {
        var stack = WorkingStack()
        stack.push(segment: This(), index: 2)
        let result = stack.body
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
    
    func testPushPointerIndexZero() {
        var stack = WorkingStack()
        stack.push(segment: Pointer(), index: 0)
        let result = stack.body
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
    
    func testPushPointerIndexOne() {
        var stack = WorkingStack()
        stack.push(segment: Pointer(), index: 1)
        let result = stack.body
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
    
    func testPushTempFirst() {
        var stack = WorkingStack()
        stack.push(segment: Temp(), index: 0)
        let result = stack.body
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
    
    func testPushTempMiddle() {
        var stack = WorkingStack()
        stack.push(segment: Temp(), index: 4)
        let result = stack.body
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
    
    func testPushTempLast() {
        var stack = WorkingStack()
        stack.push(segment: Temp(), index: 7)
        let result = stack.body
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
    
    func testPushStatic() {
        var stack = WorkingStack()
        stack.push(segment: Static(fileName: "ABC.vm"), index: 7)
        let result = stack.body
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

    func testPopLocal() {
        var stack = WorkingStack()
        stack.pop(segment: Local(), index: 0)
        let result = stack.body
        let expectation = """
        @SP
        AM=M-1
        D=M
        @LCL
        A=M
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    // A=M+1 is a little bit smatter than A=M, A=A+1. But I use fooler idea for simplify.
    func testPopArgument() {
        var stack = WorkingStack()
        stack.pop(segment: Argument(), index: 5)
        let result = stack.body
        let expectation = """
        @SP
        AM=M-1
        D=M
        @ARG
        A=M
        A=A+1
        A=A+1
        A=A+1
        A=A+1
        A=A+1
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testPopThis() {
        var stack = WorkingStack()
        stack.pop(segment: This(), index: 2)
        let result = stack.body
        let expectation = """
        @SP
        AM=M-1
        D=M
        @THIS
        A=M
        A=A+1
        A=A+1
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testPopThat() {
        var stack = WorkingStack()
        stack.pop(segment: That(), index: 1)
        let result = stack.body
        
        // @THAT is located at RAM[4].
        // @THAT represent base address of `that` segment.
        let expectation = """
        @SP
        AM=M-1
        D=M
        @THAT
        A=M
        A=A+1
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testPopPointerIndexZero() {
        var stack = WorkingStack()
        stack.pop(segment:  Pointer(), index: 0)
        let result = stack.body
        let expectation = """
        @SP
        AM=M-1
        D=M
        @THIS
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testPopPointerIndexOne() {
        var stack = WorkingStack()
        stack.pop(segment: Pointer(), index: 1)
        let result = stack.body
        let expectation = """
        @SP
        AM=M-1
        D=M
        @THAT
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testPopTempFirst() {
        var stack = WorkingStack()
        stack.pop(segment: Temp(), index: 0)
        let result = stack.body
        let expectation = """
        @SP
        AM=M-1
        D=M
        @R5
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testPopTempMiddle() {
        var stack = WorkingStack()
        stack.pop(segment: Temp(), index: 3)
        let result = stack.body
        let expectation = """
        @SP
        AM=M-1
        D=M
        @R8
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testPopTempLast() {
        var stack = WorkingStack()
        stack.pop(segment: Temp(), index: 7)
        let result = stack.body
        let expectation = """
        @SP
        AM=M-1
        D=M
        @R12
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testPopStatic() {
        var stack = WorkingStack()
        stack.pop(segment: Static(fileName: "Swift.vm"), index: 5)
        let result = stack.body
        let expectation = """
        @SP
        AM=M-1
        D=M
        @Swift.5
        M=D
        """
        XCTAssertEqual(result, expectation)
    }

}
