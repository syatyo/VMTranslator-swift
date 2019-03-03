//
//  ConditionCommand.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/27.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

enum ConditionType: String {
    case jgt
    case jeq
    case jge
    case jlt
    case jne
    case jle
    
    var value: String {
        return rawValue.uppercased()
    }
    
    var symbolIdentifer: String {
        let jIndex = rawValue.firstIndex(of: "j")!
        let afterJIndex = rawValue.index(after: jIndex)
        return String(rawValue[afterJIndex...]).uppercased()
    }
    
    var complement: ConditionType {
        switch self {
        case .jgt:
            return .jle
        case .jeq:
            return .jne
        case .jge:
            return .jlt
        case .jlt:
            return .jge
        case .jne:
            return .jeq
        case .jle:
            return .jgt
        }
    }
    
}
protocol Conditionable {
    var `type`: ConditionType { get }
    var symbolCounter: Int { get }
    mutating func incrementSymbolCounter()
}

extension Conditionable {
    
    mutating func execute() -> String {
        let conditionLabel = "END_\(type.symbolIdentifer)\(symbolCounter)"
        var builder = CommandBuilder()
        builder.add(ATCommand(difinedSymbol: .sp))
        builder.add(AssignCommand(destination: .am, computation: .mMinusOne))
        builder.add(AssignCommand(destination: .d, computation: .m))
        builder.add(AssignCommand(destination: .a, computation: .aMinusOne))
        builder.add(AssignCommand(destination: .d, computation: .mMinusD))
        builder.add(AssignCommand(destination: .m, computation: Computation(boolean: .false)))
        builder.add(ATCommand(label: conditionLabel))
        builder.add(ConditionCommand(operand: .d, conditionType: type.complement))
        builder.add(ATCommand(difinedSymbol: .sp))
        builder.add(AssignCommand(destination: .a, computation: .mMinusOne))
        builder.add(AssignCommand(destination: .m, computation: Computation(boolean: .true)))
        builder.add(LabelCommand(label: conditionLabel))
        incrementSymbolCounter()
        return builder.build()
    }
}
