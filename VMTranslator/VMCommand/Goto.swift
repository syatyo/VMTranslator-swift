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
    
    func execute() -> String {
        var builder = CommandBuilder()
        builder.add(ATCommand(label: labelName))
        builder.add(CInstruction.jump(operand: .zero, conditionType: .jmp))
        return builder.build()
    }
    
}

extension Goto: AssemblyCommandGeneratable {
    
    func generate() -> String {
        return execute()
    }
    
}
