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
        try? FileManager.default.removeItem(atPath: outputFilePath)
    }
    
    func testVMTranslateSimpleAdd() {
        // Precondition
        let outputFilePath = testOutputDirPath + "SimpleAdd.asm"
        let isFileExisted = FileManager.default.fileExists(atPath: outputFilePath)
        XCTAssertFalse(isFileExisted)
        
        let path = simpleAddPath // from Secret.swift
        let vmTranslator = VMTranslator(path: path)
        vmTranslator.startTranslating()
        vmTranslator.write()
        
        let url = URL(fileURLWithPath: outputFilePath)
        let asmText = try! String(contentsOf: url, encoding: .utf8)
        
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
