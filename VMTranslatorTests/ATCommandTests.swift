//
//  ATCommandTests.swift
//  VMTranslatorTests
//
//  Created by 山田良治 on 2019/03/03.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class ATCommandTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testATCommandFromSymbol() {
        let spCommand = ATCommand(difinedSymbol: .sp)
        XCTAssertEqual(spCommand.textRepresentation, "@SP")
        
        let lclCommand = ATCommand(difinedSymbol: .lcl)
        XCTAssertEqual(lclCommand.textRepresentation, "@LCL")

        let argCommand = ATCommand(difinedSymbol: .arg)
        XCTAssertEqual(argCommand.textRepresentation, "@ARG")

        let thisCommand = ATCommand(difinedSymbol: .this)
        XCTAssertEqual(thisCommand.textRepresentation, "@THIS")

        let thatCommand = ATCommand(difinedSymbol: .that)
        XCTAssertEqual(thatCommand.textRepresentation, "@THAT")
    }
    
    func testATCommantConstant() {
        let constantCommand = ATCommand(constant: 15)
        XCTAssertEqual(constantCommand.textRepresentation, "@15")
    }
    
}
