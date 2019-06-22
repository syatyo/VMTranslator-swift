//
//  C.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/06/17.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation
import SwiftUI

enum C: Command {
    typealias Body = String
    var body: String {
        switch self {
        case .assign(destination: let dest, computation: let comp):
            return "\(dest.value)=\(comp.value)"
            
        case .jump(operand: let operand, conditionType: let cond):
            return "\(operand.rawValue);\(cond.rawValue.uppercased())"
        }
    }
    
    enum JumpOperand: String {
        case d = "D"
        case zero = "0"
    }
    
    case assign(destination: Destination, computation: Computation)
    case jump(operand: JumpOperand, conditionType: ConditionType)
}

extension C: AssemblyCommand {
    
    func generate() -> String {
        body
    }
    
}
