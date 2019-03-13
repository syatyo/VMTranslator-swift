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
        @LCL
        D=A
        @0
        D=D+A
        @SP
        AM=M-1
        M=D
        """
        XCTAssertEqual(result, expectation)
    }

    func testPopArgument() {
        let pop = Pop(segment: .argument, index: 5)
        let result = pop.execute()
        let expectation = """
        @ARG
        D=A
        @5
        D=D+A
        @SP
        AM=M-1
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testPopThis() {
        let pop = Pop(segment: .this, index: 2)
        let result = pop.execute()
        let expectation = """
        @THIS
        D=A
        @2
        D=D+A
        @SP
        AM=M-1
        M=D
        """
        XCTAssertEqual(result, expectation)
    }

    func testPopThat() {
        let pop = Pop(segment: .that, index: 1)
        let result = pop.execute()
        let expectation = """
        @THAT
        D=A
        @1
        D=D+A
        @SP
        AM=M-1
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testPopPointer() {
        let pop = Pop(segment: .pointer, index: 3)
        let result = pop.execute()
        let expectation = """
        @3
        D=A
        @3
        D=D+A
        @SP
        AM=M-1
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testPopTemp() {
        let pop = Pop(segment: .temp, index: 5)
        let result = pop.execute()
        let expectation = """
        @5
        D=A
        @5
        D=D+A
        @SP
        AM=M-1
        M=D
        """
        XCTAssertEqual(result, expectation)

    }
}
