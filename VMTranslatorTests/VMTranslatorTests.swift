//
//  VMTranslatorTests.swift
//  VMTranslatorTests
//
//  Created by 山田良治 on 2019/02/23.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class VMTranslatorTests: XCTestCase {
    let outputFilePath = testOutputDirPath + "SimpleAdd.asm"

    override func setUp() {

    }

    override func tearDown() {
        // If I use output file in CPUEmulator to test it. Comment out this line.
        try? FileManager.default.removeItem(atPath: outputFilePath)
    }
    
    func testVMTranslateSimpleAdd() {
        // Precondition
        let outputFilePath = testOutputDirPath + "SimpleAdd.asm"
        let isFileExisted = FileManager.default.fileExists(atPath: outputFilePath)
        XCTAssertFalse(isFileExisted)
        
        let path = testOutputDirPath + "SimpleAdd.vm"
        let vmTranslator = try! VMTranslator(path: path)
        try! vmTranslator.startTranslating()
        
        let isFileExistedAfterClose = FileManager.default.fileExists(atPath: outputFilePath)
        XCTAssertTrue(isFileExistedAfterClose)
        
        let asmText = try! String(contentsOfFile: outputFilePath, encoding: .utf8)
        
        let expectation = """
        @7
        D=A
        @SP
        AM=M+1
        A=A-1
        M=D
        @8
        D=A
        @SP
        AM=M+1
        A=A-1
        M=D
        @SP
        AM=M-1
        D=M
        A=A-1
        M=D+M
        """
        
        XCTAssertEqual(asmText, expectation)
    }
    
}
