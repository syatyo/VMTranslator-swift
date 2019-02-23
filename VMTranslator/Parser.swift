//
//  Parser.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/23.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

enum VMCommandType: Int {
    case arithmetic
    case push
    case pop
    case label
    case goto
    case `if`
    case function
    case `return`
    case call
    
    init?(command: String) {
        let arithmeticSet = Set<String>(["add", "sub", "neg", "eq", "gt", "lt", "and", "or", "not"])
        let isArithmetic = arithmeticSet
            .map { command.starts(with: $0) }
            .first { $0 == true } ?? false
        
        if isArithmetic {
            self = .arithmetic
        } else if command.starts(with: "push") {
            self = .push
        } else if command.starts(with: "pop") {
            self = .pop
        } else if command.starts(with: "label") {
            self = .label
        } else if command.starts(with: "goto") {
            self = .goto
        } else if command.starts(with: "if-goto") {
            self = .if
        } else if command.starts(with: "function") {
            self = .function
        } else if command.starts(with: "call") {
            self = .call
        } else if command.starts(with: "return") {
            self = .return
        } else {
            return nil
        }
    }
    
}

struct Parser {
    
    let commands: [String]
    private var cursor: Int = 0
    private var currentCommand: String {
        return commands[cursor]
    }

    init(vmFilePath: String) {
        let url = URL(fileURLWithPath: vmFilePath)
        let commandString = try! String(contentsOf: url,
                                        encoding: .utf8)
        let formatter = CommandFormatter(source: commandString)
        formatter.removeComments()
        formatter.removeWhiteSpaces()
        formatter.removeEmptyLine()

        if formatter.text.isEmpty {
            self.commands = []
        } else {
            self.commands = formatter.text.components(separatedBy: "\n")
        }
    }
    
    var hasMoreCommands: Bool {
        return cursor != (commands.count - 1)
    }
    
    mutating func advance() {
        precondition(hasMoreCommands == true)
        cursor += 1
    }
    
    var commandType: VMCommandType {
        let vmCommand = VMCommandType(command: currentCommand)
        return vmCommand!
    }
    
}
