//
//  ParserTests.swift
//  VMTranslatorTests
//
//  Created by 山田良治 on 2019/02/23.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class ParserTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParserInit() {
        let path = testOutputDirPath + "SimpleAdd.vm"
        let parser = Parser(vmFilePath: path)
        XCTAssertEqual(parser.commands[0], "push constant 7")
        XCTAssertEqual(parser.commands[1], "push constant 8")
        XCTAssertEqual(parser.commands[2], "add")
    }
    
    func testCommandTypes() {
        let path = testOutputDirPath + "TestCommands.vm"
        var parser = Parser(vmFilePath: path)
        
        XCTAssertEqual(parser.commandType, .arithmetic)
        parser.advance()
        XCTAssertEqual(parser.commandType, .arithmetic)
        parser.advance()
        XCTAssertEqual(parser.commandType, .arithmetic)
        parser.advance()
        XCTAssertEqual(parser.commandType, .arithmetic)
        parser.advance()
        XCTAssertEqual(parser.commandType, .arithmetic)
        parser.advance()
        XCTAssertEqual(parser.commandType, .arithmetic)
        parser.advance()
        XCTAssertEqual(parser.commandType, .arithmetic)
        parser.advance()
        XCTAssertEqual(parser.commandType, .arithmetic)
        parser.advance()
        XCTAssertEqual(parser.commandType, .arithmetic)
        
        parser.advance()
        XCTAssertEqual(parser.commandType, .push)
        parser.advance()
        XCTAssertEqual(parser.commandType, .pop)

        parser.advance()
        XCTAssertEqual(parser.commandType, .label)
        parser.advance()
        XCTAssertEqual(parser.commandType, .goto)
        parser.advance()
        XCTAssertEqual(parser.commandType, .if)
        
        parser.advance()
        XCTAssertEqual(parser.commandType, .function)
        parser.advance()
        XCTAssertEqual(parser.commandType, .call)
        parser.advance()
        XCTAssertEqual(parser.commandType, .return)
    }
    
    func testArg1() {
        let path = testOutputDirPath + "TestCommands.vm"
        var parser = Parser(vmFilePath: path)
        
        XCTAssertEqual(parser.arg1, "add")
        parser.advance()
        XCTAssertEqual(parser.arg1, "sub")
        parser.advance()
        XCTAssertEqual(parser.arg1, "neg")
        parser.advance()
        XCTAssertEqual(parser.arg1, "eq")
        parser.advance()
        XCTAssertEqual(parser.arg1, "gt")
        parser.advance()
        XCTAssertEqual(parser.arg1, "lt")
        parser.advance()
        XCTAssertEqual(parser.arg1, "and")
        parser.advance()
        XCTAssertEqual(parser.arg1, "or")
        parser.advance()
        XCTAssertEqual(parser.arg1, "not")
        
        parser.advance()
        XCTAssertEqual(parser.arg1, "constant")
        parser.advance()
        XCTAssertEqual(parser.arg1, "local")
        
        parser.advance()
        XCTAssertEqual(parser.arg1, "LOOP")
        parser.advance()
        XCTAssertEqual(parser.arg1, "LOOP")
        parser.advance()
        XCTAssertEqual(parser.arg1, "END")
        
        parser.advance()
        XCTAssertEqual(parser.arg1, "testFunction")
        parser.advance()
        XCTAssertEqual(parser.arg1, "testFunction")

    }
    
    func testArg2() {
        let path = testOutputDirPath + "TestCommands.vm"
        var parser = Parser(vmFilePath: path)
        
        // no second argment.
        parser.advance()
        parser.advance()
        parser.advance()
        parser.advance()
        parser.advance()
        parser.advance()
        parser.advance()
        parser.advance()
        
        parser.advance()
        XCTAssertEqual(parser.arg2, 0)
        parser.advance()
        XCTAssertEqual(parser.arg2, 0)
        
        // no second argment.
        parser.advance()
        parser.advance()
        parser.advance()
        
        parser.advance()
        XCTAssertEqual(parser.arg2, 2)
        parser.advance()
        XCTAssertEqual(parser.arg2, 3)
        
    }

    
}
