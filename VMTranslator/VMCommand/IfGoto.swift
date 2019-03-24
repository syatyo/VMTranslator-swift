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
    
    func execute() -> String {
        var builder = CommandBuilder()
        // Start pop
        builder.add(ATCommand(difinedSymbol: .sp))
        builder.add(AssignCommand(destination: .am, computation: .mMinusOne))
        builder.add(AssignCommand(destination: .d, computation: .m))
        // End pop
        builder.add(ATCommand(label: labelName))
        builder.add(ConditionCommand(operand: .d, conditionType: .jne))
        return builder.build()
    }
    
}

extension IfGoto: AssemblyCommandGeneratable {
    
    func generate() -> String {
        return execute()
    }
    
}
