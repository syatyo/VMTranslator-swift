//
//  IfGoto.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/25.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct IfGoto {
    let labelName: String
}

extension IfGoto: VMCommand {
    
    var assemblyTranslatedCommands: [AssemblyCommand] {
        return [
            AInstruction(difinedSymbol: .sp),
            CInstruction.assign(destination: .am, computation: .mMinusOne),
            CInstruction.assign(destination: .d, computation: .m),
            AInstruction(label: labelName),
            CInstruction.jump(operand: .d, conditionType: .jne)
        ]
    }
    
}

