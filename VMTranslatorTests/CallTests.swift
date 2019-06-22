//
//  CallTests.swift
//  VMTranslatorTests
//
//  Created by 山田良治 on 2019/03/30.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class CallTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitSuccess() {
        let function = Call(name: "ArgumentTest.aaa", numberOfArguments: 1)!
        XCTAssertEqual(function.name, "ArgumentTest.aaa")
        XCTAssertEqual(function.numberOfArguments, 1)
    }
    
    /// 関数定義の仕様として、唯一数字から始まる定義だけは認めていないため、数字の場合はエラーを返す
    func testInitFailureIfFunctionNameStartsFromNumber() {
        XCTAssertNil(Call(name: "2ArgumentTest.aaa", numberOfArguments: 1))
    }
    
    func testInitFailureIfNumberOfArgumentsIsUnderZero() {
        XCTAssertNil(Call(name: "ArgumentTest.aaa", numberOfArguments: -1))
    }
    
    func testCall() {
        
    }
}
