//
//  PopTests.swift
//  VMTranslatorTests
//
//  Created by 山田良治 on 2019/03/13.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class PopTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPopLocal() {
        
        let pop = Pop(segment: .local, index: 0)
        let result = pop.execute()
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
        let pop = Pop(segment: .argument, index: 5)
        let result = pop.execute()
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
        let pop = Pop(segment: .this, index: 2)
        let result = pop.execute()
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
        let pop = Pop(segment: .that, index: 1)
        let result = pop.execute()
        
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
        let pop = Pop(segment: .pointer, index: 0)
        let result = pop.execute()
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
        let pop = Pop(segment: .pointer, index: 1)
        let result = pop.execute()
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
        let pop = Pop(segment: .temp, index: 0)
        let result = pop.execute()
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
        let pop = Pop(segment: .temp, index: 3)
        let result = pop.execute()
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
        let pop = Pop(segment: .temp, index: 7)
        let result = pop.execute()
        let expectation = """
        @SP
        AM=M-1
        D=M
        @R12
        M=D
        """
        XCTAssertEqual(result, expectation)
    }

}
