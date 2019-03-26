//
//  CommandBuilder.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/03.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct CommandBuilder {
    private var assemblyCommands: [AssemblyCommandGeneratable] = []
    
    mutating func add(_ commandGeneratable: AssemblyCommandGeneratable) {
        assemblyCommands.append(commandGeneratable)
    }
    
    mutating func add(contentsOf commandGeneratables: [AssemblyCommandGeneratable]) {
        assemblyCommands.append(contentsOf: commandGeneratables)
    }
    
    func build() -> String {
        return assemblyCommands
            .map { $0.generate() }
            .joined(separator: "\n")
    }
    
}

struct VMCommandBuilder {
    private var vmCommands: [VMCommand] = []

    mutating func add(_ vmCommand: VMCommand) {
        vmCommands.append(vmCommand)
    }
    
    func build() -> String {
        return vmCommands
            .flatMap { $0.assemblyTranslatedCommands }
            .map { $0.generate() }
            .joined(separator: "\n")
    }

}

