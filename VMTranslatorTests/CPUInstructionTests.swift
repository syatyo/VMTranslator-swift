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
        let spCommand = A(difinedSymbol: .sp)
        XCTAssertEqual(spCommand.body, "@SP")
        
        let lclCommand = A(difinedSymbol: .lcl)
        XCTAssertEqual(lclCommand.body, "@LCL")
        
        let argCommand = A(difinedSymbol: .arg)
        XCTAssertEqual(argCommand.body, "@ARG")
        
        let thisCommand = A(difinedSymbol: .this)
        XCTAssertEqual(thisCommand.body, "@THIS")
        
        let thAInstruction = A(difinedSymbol: .that)
        XCTAssertEqual(thAInstruction.body, "@THAT")
    }
    
    func testATCommantConstant() {
        let constantCommand = A(constant: 15)
        XCTAssertEqual(constantCommand.body, "@15")
    }

    func testCAssign() {
        let assingCommand = C.assign(destination: .amd, computation: .mPlusOne)
        XCTAssertEqual(assingCommand.body, "AMD=M+1")
    }
    
    func testCJump() {
        let dJump = C.jump(operand: .d, conditionType: .jeq)
        XCTAssertEqual(dJump.body, "D;JEQ")
        
        let zeroJump = C.jump(operand: .zero, conditionType: .jgt)
        XCTAssertEqual(zeroJump.body, "0;JGT")
    }

}
