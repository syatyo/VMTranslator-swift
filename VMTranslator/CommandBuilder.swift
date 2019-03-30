//
//  CommandBuilder.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/03.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct CommandBuilder<T> {
    typealias Element = T
    private var commands: [T] = []
    
    mutating func add(_ element: Element) {
        commands.append(element)
    }
    
    mutating func add(contentsOf sequence: [Element]) {
        commands.append(contentsOf: sequence)
    }

}

extension CommandBuilder where T == VMCommand {
    
    func build() -> String {
        return commands
            .flatMap { $0.assemblyTranslatedCommands }
            .map { $0.generate() }
            .joined(separator: "\n")
    }

}

extension CommandBuilder where T == AssemblyCommand {
    
    func build() -> String {
        return commands
            .map { $0.generate() }
            .joined(separator: "\n")
    }

}
