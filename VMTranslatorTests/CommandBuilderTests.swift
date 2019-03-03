//
//  CommandBuilderTests.swift
//  VMTranslatorTests
//
//  Created by 山田良治 on 2019/03/03.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class CommandBuilderTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBuildCommands() {
        var builder = CommandBuilder()
        builder.add(ATCommand(difinedSymbol: .sp))
        builder.add(AssignCommand(destination: .am, computation: .mMinusOne))
        builder.add(AssignCommand(destination: .d, computation: .m))
        builder.add(AssignCommand(destination: .a, computation: .aMinusOne))
        builder.add(AssignCommand(destination: .m, computation: .dPlusM))
        
        let result = builder.build()
        let expectation = """
        @SP
        AM=M-1
        D=M
        A=A-1
        M=D+M
        """
        
        XCTAssertEqual(result, expectation)
    }
    
}