//
//  AssignCommand.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/27.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

enum CInstruction {
    
    enum JumpOperand: String {
        case d = "D"
        case zero = "0"
    }
    
    case assign(destination: Destination, computation: Computation)
    case jump(operand: JumpOperand, conditionType: ConditionType)
}

extension CInstruction: AssemblyCommand {
    
    func generate() -> String {
        switch self {
        case .assign(destination: let dest, computation: let comp):
            return "\(dest.value)=\(comp.value)"
            
        case .jump(operand: let operand, conditionType: let cond):
            return "\(operand.rawValue);\(cond.rawValue.uppercased())"
        }
    }
    
}
