//
//  CodeWriter.swift
//  VMTranslatorTests
//
//  Created by 山田良治 on 2019/02/23.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class CodeWriterTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSetFileName() {
        let outputDirPath = "/Users/user/Documents/GitHub/VMTranslator-swift/"
        var codeWriter = CodeWriter(outputDirPath: outputDirPath)
        codeWriter.setFileName("test.asm")
        XCTAssertEqual(codeWriter.outputFilePath, "/Users/user/Documents/GitHub/VMTranslator-swift/test.asm")
    }
    
}
