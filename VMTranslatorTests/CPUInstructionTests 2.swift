//
//  CPUInstructionTests.swift
//  VMTranslatorTests
//
//  Created by 山田良治 on 2019/06/17.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class CPUInstructionTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAInstructionFromSymbol() {
        let spCommand = A.symbol(.sp)
        XCTAssertEqual(spCommand.body, "@SP")
        
        let lclCommand = A.symbol(.lcl)
        XCTAssertEqual(lclCommand.body, "@LCL")
        
        let argCommand = A.symbol(.arg)
        XCTAssertEqual(argCommand.body, "@ARG")
        
        let thisCommand = A.symbol(.this)
        XCTAssertEqual(thisCommand.body, "@THIS")
        
        let thAInstruction = A.symbol(.that)
        XCTAssertEqual(thAInstruction.body, "@THAT")
    }
    
    func testATCommantConstant() {
        let constantCommand = A.constant(15)
        XCTAssertEqual(constantCommand.body, "@15")
    }

}
