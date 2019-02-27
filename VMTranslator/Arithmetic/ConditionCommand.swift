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
protocol ConditionCommand {
    var `type`: ConditionType { get }
    var symbolCounter: Int { get }
    mutating func incrementSymbolCounter()
}

extension ConditionCommand {
    
    mutating func execute() -> String {
        var lines: [String] = []
        lines.append("@SP")
        lines.append("AM=M-1")
        lines.append("D=M")
        lines.append("A=A-1")
        lines.append("D=M-D")
        lines.append("M=\(Assembly.false)")
        lines.append("@END_\(type.symbolIdentifer)\(symbolCounter)")
        lines.append("D;\(type.complement.value)")
        lines.append("@SP")
        lines.append("A=M-1")
        lines.append("M=\(Assembly.true)")
        lines.append("(END_\(type.symbolIdentifer)\(symbolCounter))")
        incrementSymbolCounter()
        return lines.joined(separator: "\n")
    }
}
