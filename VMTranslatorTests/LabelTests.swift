//
//  LabelTests.swift
//  VMTranslatorTests
//
//  Created by 山田良治 on 2019/03/24.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class LabelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLabel() {
        let label = Label(name: "null$LOOP_START")
        let result = label.assemblyTranslatedCommands.map { $0.generate() }.joined(separator: "\n")
        let expectation = """
        (null$LOOP_START)
        """
        XCTAssertEqual(result, expectation)
    }
    
}
