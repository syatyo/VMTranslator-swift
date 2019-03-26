//
//  Goto.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/25.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Goto {
    let labelName: String
}

extension Goto: VMCommand {
    
    var assemblyTranslatedCommands: [AssemblyCommand] {
        return [
            AInstruction(label: labelName),
            CInstruction.jump(operand: .zero, conditionType: .jmp)
        ]
    }
    
}
