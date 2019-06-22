//
//  Goto.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/25.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Goto: Command {
    let labelName: String
    
    var body: String {
        NewAssemblyCommand {
            A.label(labelName)
            C.jump(operand: .zero, conditionType: .jmp)
        }.body
    }
}

extension Goto: VMCommand {
    
    var assemblyTranslatedCommands: [AssemblyCommand] {
        return [
            A.label(labelName),
            C.jump(operand: .zero, conditionType: .jmp)
        ]
    }
    
}
