//
//  Greater.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/27.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Greater: Conditionable, Command {
    
    var conditionType: ConditionType { return .jgt }
    private(set) var repository: ConditionIndexRepository!
    mutating func inject(repository: ConditionIndexRepository) {
        self.repository = repository
    }

    var body: String {
        let incrementedValue = repository.incrementIndex(for: String(describing: type(of: self)))
        let conditionLabel = "END_\(conditionType.symbolIdentifer)\(incrementedValue)"
        
        return NewAssemblyCommand {
            A.symbol(.sp)
            C.assign(destination: .am, computation: .mMinusOne)
            C.assign(destination: .d, computation: .m)
            C.assign(destination: .a, computation: .aMinusOne)
            C.assign(destination: .d, computation: .mMinusD)
            C.assign(destination: .m, computation: Computation(boolean: .false))
            A.label(conditionLabel)
            C.jump(operand: .d, conditionType: conditionType.complement)
            A.symbol(.sp)
            C.assign(destination: .a, computation: .mMinusOne)
            C.assign(destination: .m, computation: Computation(boolean: .true))
            LabelSymbol(label: conditionLabel)
        }.body
    }

}
