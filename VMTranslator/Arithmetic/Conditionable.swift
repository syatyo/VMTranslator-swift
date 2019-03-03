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
        var lines: [String] = []
        lines.append("@SP")
        lines.append(AssignCommand(destination: .am, computation: .mMinusOne).textRepresentation)
        lines.append(AssignCommand(destination: .d, computation: .m).textRepresentation)
        lines.append(AssignCommand(destination: .a, computation: .aMinusOne).textRepresentation)
        lines.append(AssignCommand(destination: .d, computation: .mMinusD).textRepresentation)
        lines.append(AssignCommand(destination: .m, computation: Computation(boolean: .false)).textRepresentation)
        lines.append("@END_\(type.symbolIdentifer)\(symbolCounter)")
        lines.append("D;\(type.complement.value)")
        lines.append("@SP")
        lines.append(AssignCommand(destination: .a, computation: .mMinusOne).textRepresentation)
        lines.append(AssignCommand(destination: .m, computation: Computation(boolean: .true)).textRepresentation)
        lines.append("(END_\(type.symbolIdentifer)\(symbolCounter))")
        incrementSymbolCounter()
        return lines.joined(separator: "\n")
    }
}
