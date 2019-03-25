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
        builder.add(AInstruction(difinedSymbol: .sp))
        builder.add(CInstruction.assign(destination: .am, computation: .mMinusOne))
        builder.add(CInstruction.assign(destination: .d, computation: .m))
        // End pop
        builder.add(AInstruction(label: labelName))
        builder.add(CInstruction.jump(operand: .d, conditionType: .jne))
        return builder.build()
    }
    
}

extension IfGoto: AssemblyCommandGeneratable {
    
    func generate() -> String {
        return execute()
    }
    
}
