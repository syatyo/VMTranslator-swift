//
//  ConditionCommand.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/27.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

enum ConditionType: String {
    case jmp // force jump
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
        case .jmp:
            return .jmp
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
    var conditionType: ConditionType { get }
    var repository: ConditionIndexRepository! { get }
    
    mutating func inject(repository: ConditionIndexRepository)
}

extension Conditionable {
    
    func execute() -> String {
        let currentIndex = repository.getCurrentValue(for: String(describing: type(of: self)))
        
        let conditionLabel = "END_\(conditionType.symbolIdentifer)\(currentIndex)"
        var builder = CommandBuilder()
        builder.add(AInstruction(difinedSymbol: .sp))
        builder.add(CInstruction.assign(destination: .am, computation: .mMinusOne))
        builder.add(CInstruction.assign(destination: .d, computation: .m))
        builder.add(CInstruction.assign(destination: .a, computation: .aMinusOne))
        builder.add(CInstruction.assign(destination: .d, computation: .mMinusD))
        builder.add(CInstruction.assign(destination: .m, computation: Computation(boolean: .false)))
        builder.add(AInstruction(label: conditionLabel))
        builder.add(CInstruction.jump(operand: .d, conditionType: conditionType.complement))
        builder.add(AInstruction(difinedSymbol: .sp))
        builder.add(CInstruction.assign(destination: .a, computation: .mMinusOne))
        builder.add(CInstruction.assign(destination: .m, computation: Computation(boolean: .true)))
        builder.add(LabelCommand(label: conditionLabel))
        
        repository.incrementIndex(for: String(describing: type(of: self)))
        return builder.build()
    }
}
