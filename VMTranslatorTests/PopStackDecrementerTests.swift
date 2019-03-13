//
//  PopDecrementerTests.swift
//  VMTranslatorTests
//
//  Created by 山田良治 on 2019/03/13.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class PopStackDecrementerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecrementer() {
        let popStackDecrementer = PopStackDecrementer()
        let result = popStackDecrementer.execute()
        let expectation = """
        @SP
        AM=M-1
        M=D
        """
        XCTAssertEqual(result, expectation)
    }
}
