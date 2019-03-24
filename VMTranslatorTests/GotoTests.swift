//
//  GotoTests.swift
//  VMTranslatorTests
//
//  Created by 山田良治 on 2019/03/24.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class GotoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGoto() {
        let goto = Goto(labelName: "null$LOOP_START")
        let result = goto.execute()
        let expectation = """
        @null$LOOP_START
        0;JMP
        """
        XCTAssertEqual(result, expectation)
    }
    
}
