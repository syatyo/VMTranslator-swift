//
//  AndTests.swift
//  VMTranslatorTests
//
//  Created by 山田良治 on 2019/02/27.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class AndTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExecute() {
        let result = And().execute()
        let expectation = """
        @SP
        AM=M-1
        D=M
        A=A-1
        M=M&D
        """
        XCTAssertEqual(result, expectation)
    }

}
