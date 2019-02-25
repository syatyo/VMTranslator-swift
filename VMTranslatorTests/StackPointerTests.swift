//
//  StackPointerTests.swift
//  VMTranslatorTests
//
//  Created by 山田良治 on 2019/02/25.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class StackPointerTests: XCTestCase {
    let sp = StackPointer()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testIncreament() {
        let result = sp.increment()
        let expectation = """
        @SP
        M=M+1
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testDecrement() {
        let result = sp.decrement()
        let expectation = """
        @SP
        M=M-1
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testMakeARegisterPointFirstArgument() {
        let result = sp.makeARegisterPointFirstArgument()
        let expectation = """
        @SP
        A=M-1
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testMakeARegisterPointSecondArgument() {
        let result = sp.makeARegisterPointSecondArgument()
        let expectation = """
        @SP
        A=M-1
        A=A-1
        """
        XCTAssertEqual(result, expectation)
    }
}
