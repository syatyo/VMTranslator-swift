//
//  FunctionTests.swift
//  VMTranslatorTests
//
//  Created by 山田良治 on 2019/03/30.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class FunctionTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitSuccess() {
        let function = Function(name: "FunctionTest.aaa", numberOfLocalVariables: 1)!
        XCTAssertEqual(function.name, "FunctionTest.aaa")
        XCTAssertEqual(function.numberOfLocalVariables, 1)
    }
    
    /// 関数定義の仕様として、唯一数字から始まる定義だけは認めていないため、数字の場合はエラーを返す
    func testInitFailureIfFunctionNameStartsFromNumber() {
        XCTAssertNil(Function(name: "2FunctionTest.aaa", numberOfLocalVariables: 1))
    }

    func testInitFailureIfNumberOfLocalVarialbesIsUnderZero() {
        XCTAssertNil(Function(name: "FunctionTest.aaa", numberOfLocalVariables: -1))
    }
    
    func testPushLocalVariables() {
        var function = Function(name: "FunctionTest.aaa", numberOfLocalVariables: 2)!
        let expectation = """
        @SP
        AM=M+1
        A=A-1
        M=0
        @SP
        AM=M+1
        A=A-1
        M=0
        """
        
        function.pushLocalVariable()
        XCTAssertEqual(build(assemblyCommands: function.assemblyTranslatedCommands),
                       expectation)
    }
    
}

func build(assemblyCommands: [AssemblyCommand]) -> String {
    return assemblyCommands.map { $0.generate() }.joined(separator: "\n")
}
