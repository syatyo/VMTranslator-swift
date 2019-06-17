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
            A.symbol(.sp),
            C.assign(destination: .am, computation: .mMinusOne),
            C.assign(destination: .d, computation: .m),
            A.label(labelName),
            C.jump(operand: .d, conditionType: .jne)
        ]
    }
    
}

