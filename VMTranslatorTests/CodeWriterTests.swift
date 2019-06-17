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
        XCTAssertEqual(codeWriter.fileName, "test.asm")
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
        codeWriter.writePushPop(.push, segment: "constant", index: 8)
        
        // We don't have to initialize segment memories. In this section, test script setup them.
        let expectation = """
        @8
        D=A
        @SP
        AM=M+1
        A=A-1
        M=D
        """
        
        XCTAssertEqual(codeWriter.assembly, expectation)
    }
    
    func testWriteAdd() {
        var codeWriter = CodeWriter(outputDirPath: testOutputDirPath)
        codeWriter.setFileName("testAdd.asm")
        codeWriter.writeArithmetic(command: "add")
        
        let expectation = """
        @SP
        AM=M-1
        D=M
        A=A-1
        M=D+M
        """
        
        XCTAssertEqual(codeWriter.assembly, expectation)
    }
    
    func testWriteSub() {
        var codeWriter = CodeWriter(outputDirPath: testOutputDirPath)
        codeWriter.setFileName("testSub.asm")
        codeWriter.writeArithmetic(command: "sub")
        
        let expectation = """
        @SP
        AM=M-1
        D=M
        A=A-1
        M=M-D
        """
        
        XCTAssertEqual(codeWriter.assembly, expectation)
    }
    
    func testWriteNeg() {
        var codeWriter = CodeWriter(outputDirPath: testOutputDirPath)
        codeWriter.setFileName("testNeg.asm")
        codeWriter.writeArithmetic(command: "neg")
        
        let expectation = """
        @SP
        A=M-1
        M=-M
        """
        
        XCTAssertEqual(codeWriter.assembly, expectation)
    }
    
    func testWriteEq() {
        var codeWriter = CodeWriter(outputDirPath: testOutputDirPath)
        codeWriter.setFileName("testEq.asm")
        codeWriter.writeArithmetic(command: "eq")
        
        let expectation = """
        @SP
        AM=M-1
        D=M
        A=A-1
        D=M-D
        M=0
        @END_EQ1
        D;JNE
        @SP
        A=M-1
        M=-1
        (END_EQ1)
        """
        
        XCTAssertEqual(codeWriter.assembly, expectation)
    }
    
    func testWriteGt() {
        var codeWriter = CodeWriter(outputDirPath: testOutputDirPath)
        codeWriter.setFileName("testGt.asm")
        codeWriter.writeArithmetic(command: "gt")
        
        let expectation = """
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
        
        XCTAssertEqual(codeWriter.assembly, expectation)
    }
    
    func testWriteLt() {
        var codeWriter = CodeWriter(outputDirPath: testOutputDirPath)
        codeWriter.setFileName("testLt.asm")
        codeWriter.writeArithmetic(command: "lt")
        
        let expectation = """
        @SP
        AM=M-1
        D=M
        A=A-1
        D=M-D
        M=0
        @END_LT1
        D;JGE
        @SP
        A=M-1
        M=-1
        (END_LT1)
        """
        
        XCTAssertEqual(codeWriter.assembly, expectation)
    }
    
    func testWriteAnd() {
        var codeWriter = CodeWriter(outputDirPath: testOutputDirPath)
        codeWriter.setFileName("testAnd.asm")
        codeWriter.writeArithmetic(command: "and")
        
        let expectation = """
        @SP
        AM=M-1
        D=M
        A=A-1
        M=D&M
        """
        
        XCTAssertEqual(codeWriter.assembly, expectation)
    }
    
    func testWriteOr() {
        var codeWriter = CodeWriter(outputDirPath: testOutputDirPath)
        codeWriter.setFileName("testOr.asm")
        codeWriter.writeArithmetic(command: "or")
        
        let expectation = """
        @SP
        AM=M-1
        D=M
        A=A-1
        M=D|M
        """
        
        XCTAssertEqual(codeWriter.assembly, expectation)
    }
    
    func testWriteNot() {
        var codeWriter = CodeWriter(outputDirPath: testOutputDirPath)
        codeWriter.setFileName("testNot.asm")
        codeWriter.writeArithmetic(command: "not")
        
        let expectation = """
        @SP
        A=M-1
        M=!M
        """
        
        XCTAssertEqual(codeWriter.assembly, expectation)
    }
    
    func testSimpleAdd() {
        var codeWriter = CodeWriter(outputDirPath: testOutputDirPath)
        codeWriter.setFileName("testSimpleAdd.asm")
        codeWriter.writePushPop(.push, segment: "constant", index: 7)
        codeWriter.writePushPop(.push, segment: "constant", index: 8)
        codeWriter.writeArithmetic(command: "add")
        
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
        XCTAssertEqual(codeWriter.assembly, expectation)
    }
    
    func testWriteLabel() {
        var codeWriter = CodeWriter(outputDirPath: testOutputDirPath)
        codeWriter.setFileName("testLabel.asm")
        codeWriter.writeLabel("label-func$label")
        
        let expectation = """
        (label-func$label)
        """
        XCTAssertEqual(codeWriter.assembly, expectation)
    }
    
    func testWriteGoto() {
        var codeWriter = CodeWriter(outputDirPath: testOutputDirPath)
        codeWriter.setFileName("testGoto.asm")
        codeWriter.writeGoto("goto-func$label")
        
        let expectation = """
        @goto-func$label
        0;JMP
        """
        XCTAssertEqual(codeWriter.assembly, expectation)
    }
    
    func testWriteIf() {
        var codeWriter = CodeWriter(outputDirPath: testOutputDirPath)
        codeWriter.setFileName("testIf.asm")
        codeWriter.writeIf("if-func$label")
        
        let expectation = """
        @SP
        AM=M-1
        D=M
        @if-func$label
        D;JNE
        """
        XCTAssertEqual(codeWriter.assembly, expectation)
    }

}
