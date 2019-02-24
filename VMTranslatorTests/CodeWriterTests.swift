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
    
    func testClose() {
        var codeWriter = CodeWriter(outputDirPath: testOutputDirPath)
        codeWriter.setFileName("testClose.asm")
        try! codeWriter.close()
        
        let isFileSaved = FileManager.default.fileExists(atPath: testOutputDirPath + "testClose.asm")
        XCTAssertTrue(isFileSaved)
        try! FileManager.default.removeItem(atPath: testOutputDirPath + "testClose.asm")
    }
    
    func testWritePush() {
        
        var codeWriter = CodeWriter(outputDirPath: testOutputDirPath)
        codeWriter.setFileName("test.asm")
        codeWriter.writePushPop(.push, segmentType: .constant, index: 8)
        
        // We don't have to initialize segment memories. In this section, test script setup them.
        let expectation = """
        @8
        D=A
        @SP
        A=M
        M=D
        @SP
        M=M+1
        """
        
        XCTAssertEqual(codeWriter.assembly, expectation)
    }
    
}
