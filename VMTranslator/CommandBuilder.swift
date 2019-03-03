//
//  CommandBuilder.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/03.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct CommandBuilder {
    private var assemblyCommands: [AssemblyCommand] = []
    
    mutating func add(_ command: AssemblyCommand) {
        assemblyCommands.append(command)
    }
    
    func build() -> String {
        return assemblyCommands
            .map { $0.textRepresentation }
            .joined(separator: "\n")
    }
    
}
