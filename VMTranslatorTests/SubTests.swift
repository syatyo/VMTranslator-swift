//
//  SubTests.swift
//  VMTranslatorTests
//
//  Created by 山田良治 on 2019/02/24.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class SubTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSub() {
        let result = Sub().execute()
        let expectation = """
        @SP
        A=M-1
        D=M
        A=A-1
        D=D-M
        M=D
        @SP
        M=M-1
        """
        XCTAssertEqual(result, expectation)
    }

}
