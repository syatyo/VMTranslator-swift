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
        let path = simpleAddPath // from Secret.swift
        let parser = Parser(vmFilePath: path)
        XCTAssertEqual(parser.commands[0], "push constant 7")
        XCTAssertEqual(parser.commands[1], "push constant 8")
        XCTAssertEqual(parser.commands[2], "add")
    }
    
    func testCommandTypes() {
        let path = testCommandTypesPath
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
}
