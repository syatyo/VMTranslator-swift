//
//  NewAssemblyCommand.swift
//  VMTranslatorTests
//
//  Created by 山田良治 on 2019/06/17.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class NewAssemblyCommandTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCommandBuilder() {
        
        let assemblyCommand = NewAssemblyCommand {
            A(difinedSymbol: .sp)
            C.assign(destination: .d, computation: .m)
            A(constant: 10)
        }
        
        let expectation = """
        @SP
        D=M
        @10
        """
        XCTAssertEqual(assemblyCommand.body, expectation)
    }
}
