//
//  Parser.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/23.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Parser {
    
    let commands: [String]
    init(vmFilePath: String) {
        let url = URL(fileURLWithPath: vmFilePath)
        let commandString = try! String(contentsOf: url,
                                        encoding: .utf8)
        let formatter = CommandFormatter(source: commandString)
        formatter.removeComments()
        formatter.removeEmptyLine()

        if formatter.text.isEmpty {
            self.commands = []
        } else {
            self.commands = formatter.text.components(separatedBy: "\n")
        }
    }
    
}
