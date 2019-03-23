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
    
    func testConstant() {
        let segment = Constant()
        let result = segment
            .pushCommands(index: 5)
            .map { $0.generate() }
            .joined(separator: "\n")
        
        let expectation = """
        @5
        D=A
        """
        
        XCTAssertEqual(result, expectation)
    }

    func testLocal() {
        let segment = Local()
        let result = segment.pushCommands(index: 5).map { $0.generate() }.joined(separator: "\n")
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
        let segment = Argument()
        let result = segment.pushCommands(index: 2).map { $0.generate() }.joined(separator: "\n")
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
        let segment = This()
        let result = segment.pushCommands(index: 2).map { $0.generate() }.joined(separator: "\n")
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
        let segment = That()
        let result = segment.pushCommands(index: 1).map { $0.generate() }.joined(separator: "\n")
        
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
        let segment = Pointer()
        let result = segment.pushCommands(index: 0).map { $0.generate() }.joined(separator: "\n")
        let expectation = """
        @THIS
        D=M
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testPointerIndexOne() {
        let segment = Pointer()
        let result = segment.pushCommands(index: 1).map { $0.generate() }.joined(separator: "\n")
        let expectation = """
        @THAT
        D=M
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testTempFirst() {
        let segment = Temp()
        let result = segment.pushCommands(index: 0).map { $0.generate() }.joined(separator: "\n")
        let expectation = """
        @R5
        D=M
        """
        XCTAssertEqual(result, expectation)
    }

    func testTempMiddle() {
        let segment = Temp()
        let result = segment.pushCommands(index: 4).map { $0.generate() }.joined(separator: "\n")
        let expectation = """
        @R9
        D=M
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testTemp() {
        let segment = Temp()
        let result = segment.pushCommands(index: 7).map { $0.generate() }.joined(separator: "\n")
        let expectation = """
        @R12
        D=M
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testPushStatic() {
        let segment = Static(fileName: "Xxx.vm")
        let result = segment
            .pushCommands(index: 7)
            .map { $0.generate() }
            .joined(separator: "\n")
        
        let expectation = """
        @Xxx.7
        D=M
        """
        XCTAssertEqual(result, expectation)
    }
    
    func testPopStatic() {
        let segment = Static(fileName: "Xxx.vm")
        let result = segment
            .popCommands(index: 7)
            .map { $0.generate() }
            .joined(separator: "\n")
        
        let expectation = """
        @Xxx.7
        """
        XCTAssertEqual(result, expectation)
    }

    
}
