//
//  ConditionCommand.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/03.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

/// left;JUMP command in assembly.
struct ConditionCommand {
    
    enum Operand: String {
        case d = "D"
        case zero = "0"
    }
    
    var operand: Operand
    var conditionType: ConditionType
}

extension ConditionCommand: AssemblyCommandGeneratable {
    
    func generateAssembly() -> String {
        return "\(operand.rawValue);\(conditionType.rawValue.uppercased())"
    }
    
}
