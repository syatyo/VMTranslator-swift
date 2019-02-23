//
//  CommandFormatterTests.swift
//  HackAssemblerTests
//
//  Created by 山田良治 on 2019/01/09.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class CommandFormatterTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRemoveComments() {
        let testString = """
        // This file is part of www.nand2tetris.org
        // and the book "The Elements of Computing Systems"
        // by Nisan and Schocken, MIT Press.
        // File name: projects/07/StackArithmetic/SimpleAdd/SimpleAdd.vm

        // Pushes and adds two constants.
        push constant 7
        push constant 8
        add
        """
        let formatter = CommandFormatter(source: testString)
        formatter.removeComments()
        
        // コメント削除時の空行削除はされない
        let expectedString = """






        push constant 7
        push constant 8
        add
        """

        XCTAssertEqual(formatter.text, expectedString)
    }
    
    func testRemoveEmptyLine() {
        let testString = """
        // This file is part of www.nand2tetris.org
        // and the book "The Elements of Computing Systems"
        // by Nisan and Schocken, MIT Press.
        // File name: projects/07/StackArithmetic/SimpleAdd/SimpleAdd.vm

        // Pushes and adds two constants.
        push constant 7
        push constant 8
        add
        """
        
        let formatter = CommandFormatter(source: testString)
        
        let expectedString = """
        // This file is part of www.nand2tetris.org
        // and the book "The Elements of Computing Systems"
        // by Nisan and Schocken, MIT Press.
        // File name: projects/07/StackArithmetic/SimpleAdd/SimpleAdd.vm
        // Pushes and adds two constants.
        push constant 7
        push constant 8
        add
        """

        formatter.removeEmptyLine()
        
        XCTAssertEqual(formatter.text, expectedString)
    }
    
    func testFormatVMString() {
        let testString = """
        // This file is part of www.nand2tetris.org
        // and the book "The Elements of Computing Systems"
        // by Nisan and Schocken, MIT Press.
        // File name: projects/07/StackArithmetic/SimpleAdd/SimpleAdd.vm

        // Pushes and adds two constants.
        push constant 7
        push constant 8
        add
        """
        
        let formatter = CommandFormatter(source: testString)
        formatter.removeComments()
        formatter.removeEmptyLine()
        
        let expectedString = """
        push constant 7
        push constant 8
        add
        """
        
        formatter.removeEmptyLine()
        
        XCTAssertEqual(formatter.text, expectedString)
    }
    
}
