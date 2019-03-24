//
//  IfGotoTests.swift
//  VMTranslatorTests
//
//  Created by 山田良治 on 2019/03/25.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class IfGotoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testIfGoto() {
        let ifGoto = IfGoto(labelName: "null$LOOP_START")
        let result = ifGoto.execute()
        
        // 1. pop stack value
        // 2. if poped value is not zero, jump to label address.
        let expectation = """
        @SP
        AM=M-1
        D=M
        @null$LOOP_START
        D;JNE
        """
        XCTAssertEqual(result, expectation)
    }
    
}
