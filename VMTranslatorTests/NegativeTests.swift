//
//  NegativeTests.swift
//  VMTranslatorTests
//
//  Created by 山田良治 on 2019/02/25.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class NegativeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExecute() {
        let result = Negative().execute()
        let expectation = """
        @SP
        A=M-1
        M=!M
        """
        XCTAssertEqual(result, expectation)
    }
    
}
