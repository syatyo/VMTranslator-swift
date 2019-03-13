//
//  ConditionCommandTests.swift
//  VMTranslatorTests
//
//  Created by 山田良治 on 2019/03/03.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class ConditionCommandTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testConditionCommand() {
        let dJump = ConditionCommand(operand: .d, conditionType: .jeq)
        XCTAssertEqual(dJump.generate(), "D;JEQ")
        
        let zeroJump = ConditionCommand(operand: .zero, conditionType: .jgt)
        XCTAssertEqual(zeroJump.generate(), "0;JGT")
    }
    
}
