//
//  AInstructionTests.swift
//  VMTranslatorTests
//
//  Created by 山田良治 on 2019/03/03.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class AInstructionTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAInstructionFromSymbol() {
        let spCommand = AInstruction(difinedSymbol: .sp)
        XCTAssertEqual(spCommand.generate(), "@SP")
        
        let lclCommand = AInstruction(difinedSymbol: .lcl)
        XCTAssertEqual(lclCommand.generate(), "@LCL")

        let argCommand = AInstruction(difinedSymbol: .arg)
        XCTAssertEqual(argCommand.generate(), "@ARG")

        let thisCommand = AInstruction(difinedSymbol: .this)
        XCTAssertEqual(thisCommand.generate(), "@THIS")

        let thAInstruction = AInstruction(difinedSymbol: .that)
        XCTAssertEqual(thAInstruction.generate(), "@THAT")
    }
    
    func testATCommantConstant() {
        let constantCommand = AInstruction(constant: 15)
        XCTAssertEqual(constantCommand.generate(), "@15")
    }
    
}
