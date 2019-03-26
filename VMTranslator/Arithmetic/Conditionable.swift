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
    
    func translateToAssemblyCommands() -> [AssemblyCommandGeneratable] {
        let currentIndex = repository.getCurrentValue(for: String(describing: type(of: self)))
        let conditionLabel = "END_\(conditionType.symbolIdentifer)\(currentIndex)"
        
        var commands: [AssemblyCommandGeneratable] = []
        commands.append(AInstruction(difinedSymbol: .sp))
        commands.append(CInstruction.assign(destination: .am, computation: .mMinusOne))
        commands.append(CInstruction.assign(destination: .d, computation: .m))
        commands.append(CInstruction.assign(destination: .a, computation: .aMinusOne))
        commands.append(CInstruction.assign(destination: .d, computation: .mMinusD))
        commands.append(CInstruction.assign(destination: .m, computation: Computation(boolean: .false)))
        commands.append(AInstruction(label: conditionLabel))
        commands.append(CInstruction.jump(operand: .d, conditionType: conditionType.complement))
        commands.append(AInstruction(difinedSymbol: .sp))
        commands.append(CInstruction.assign(destination: .a, computation: .mMinusOne))
        commands.append(CInstruction.assign(destination: .m, computation: Computation(boolean: .true)))
        commands.append(LabelSymbolInstruction(label: conditionLabel))
        
        repository.incrementIndex(for: String(describing: type(of: self)))
        return commands
    }
    
}
