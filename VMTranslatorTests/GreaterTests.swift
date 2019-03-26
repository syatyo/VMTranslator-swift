//
//  GreaterTests.swift
//  VMTranslatorTests
//
//  Created by 山田良治 on 2019/02/27.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class GreaterTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExecute() {
        var greater = Greater()
        greater.inject(repository: Store())
        
        let result1 = greater.assemblyTranslatedCommands.map { $0.generate() }.joined(separator: "\n")
        let expectation1 = """
        @SP
        AM=M-1
        D=M
        A=A-1
        D=M-D
        M=0
        @END_GT0
        D;JLE
        @SP
        A=M-1
        M=-1
        (END_GT0)
        """
        
        let result2 = greater.assemblyTranslatedCommands.map { $0.generate() }.joined(separator: "\n")
        let expectation2 = """
        @SP
        AM=M-1
        D=M
        A=A-1
        D=M-D
        M=0
        @END_GT1
        D;JLE
        @SP
        A=M-1
        M=-1
        (END_GT1)
        """
        
        XCTAssertEqual(result1, expectation1)
        XCTAssertEqual(result2, expectation2)
    }

}

private final class Store: ConditionIndexRepository {
    private var counter: Int = 0
    
    func getCurrentValue(for type: String) -> Int {
        return counter
    }
    
    func incrementIndex(for type: String) {
        counter += 1
    }
    
}
