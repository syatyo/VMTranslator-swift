//
//  EqualTests.swift
//  VMTranslatorTests
//
//  Created by 山田良治 on 2019/02/25.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class EqualTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExecute() {
        var equal = Equal()
        let result1 = equal.execute()
        let expectation1 = """
        @SP
        AM=M-1
        D=M
        A=A-1
        D=M-D
        M=0
        @END_EQ0
        D;JEQ
        @SP
        A=M-1
        M=-1
        (END_EQ0)
        """
        
        let result2 = equal.execute()
        let expectation2 = """
        @SP
        AM=M-1
        D=M
        A=A-1
        D=M-D
        M=0
        @END_EQ1
        D;JEQ
        @SP
        A=M-1
        M=-1
        (END_EQ1)
        """
        
        XCTAssertEqual(result1, expectation1)
        XCTAssertEqual(result2, expectation2)
    }

}
