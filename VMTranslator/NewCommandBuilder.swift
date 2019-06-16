//
//  NewCommandBuilder.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/06/17.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

protocol Command {
    
    var body: String { get }
    
}

@_functionBuilder
struct NewCommandBuilder {
    
    public static func buildBlock<Content>(_ content: Content) -> String where Content: Command {
        content.body
    }
    
    public static func buildBlock<T1, T2>(_ t1: T1, _ t2: T2) -> String where T1: Command, T2: Command {
        [t1.body, t2.body]
            .joined(separator: "\n")
    }
    
    public static func buildBlock<T1, T2, T3>(_ t1: T1, _ t2: T2, _ t3: T3) -> String where T1: Command, T2: Command, T3: Command {
        [t1.body, t2.body, t3.body]
            .joined(separator: "\n")
    }
    
    public static func buildBlock<T1, T2, T3, T4>(_ t1: T1, _ t2: T2, _ t3: T3, _ t4: T4) -> String where T1: Command, T2: Command, T3: Command, T4: Command {
        [t1.body, t2.body, t3.body, t4.body]
            .joined(separator: "\n")
    }
    
    public static func buildBlock<T1, T2, T3, T4, T5>(_ t1: T1, _ t2: T2, _ t3: T3, _ t4: T4, _ t5: T5) -> String where T1: Command, T2: Command, T3: Command, T4: Command, T5: Command {
        [t1.body, t2.body, t3.body, t4.body, t5.body]
            .joined(separator: "\n")
    }
    
    public static func buildBlock<T1, T2, T3, T4, T5, T6>(_ t1: T1, _ t2: T2, _ t3: T3, _ t4: T4, _ t5: T5, _ t6: T6) -> String where T1: Command, T2: Command, T3: Command, T4: Command, T5: Command, T6: Command {
        [t1.body, t2.body, t3.body, t4.body, t5.body, t6.body]
            .joined(separator: "\n")
    }
    
    public static func buildBlock<T1, T2, T3, T4, T5, T6, T7>(_ t1: T1, _ t2: T2, _ t3: T3, _ t4: T4, _ t5: T5, _ t6: T6, _ t7: T7) -> String where T1: Command, T2: Command, T3: Command, T4: Command, T5: Command, T6: Command, T7: Command {
        [t1.body, t2.body, t3.body, t4.body, t5.body, t6.body, t7.body]
            .joined(separator: "\n")
    }
    
    public static func buildBlock<T1, T2, T3, T4, T5, T6, T7, T8>(_ t1: T1, _ t2: T2, _ t3: T3, _ t4: T4, _ t5: T5, _ t6: T6, _ t7: T7, _ t8: T8) -> String where T1: Command, T2: Command, T3: Command, T4: Command, T5: Command, T6: Command, T7: Command, T8: Command {
        [t1.body, t2.body, t3.body, t4.body, t5.body, t6.body, t7.body, t8.body]
            .joined(separator: "\n")
    }
    
    public static func buildBlock<T1, T2, T3, T4, T5, T6, T7, T8, T9>(_ t1: T1, _ t2: T2, _ t3: T3, _ t4: T4, _ t5: T5, _ t6: T6, _ t7: T7, _ t8: T8, _ t9: T9) -> String where T1: Command, T2: Command, T3: Command, T4: Command, T5: Command, T6: Command, T7: Command, T8: Command, T9: Command {
        [t1.body, t2.body, t3.body, t4.body, t5.body, t6.body, t7.body, t8.body, t9.body]
            .joined(separator: "\n")
    }
    
}

private extension Collection where Self.Element: Command {
    
    func build() -> String {
        self
            .map { $0.body }
            .joined(separator: "\n")
    }
    
}

struct NewAssemblyCommand: Command {
    var body: String

    init(@NewCommandBuilder builder: () -> String) {
        body = builder()
    }
    
}

/// @value command in assembly. It assign given value to A register.
struct A: Command {
    typealias Body = String
    var body: String
    
    enum DefinedSymbol: String {
        case sp
        case lcl
        case arg
        case this
        case that
    }
    
    init(difinedSymbol: DefinedSymbol) {
        self.body = "@\(difinedSymbol.rawValue.uppercased())"
    }
    
    init(constant: Int) {
        self.body = "@\(constant.description)"
    }
    
    init(label: String) {
        self.body = "@\(label)"
    }
    
}

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

struct NewPush: Command {
    var index: Int
    var `type`: A.DefinedSymbol
    
    var body: String {
        NewAssemblyCommand {
            A(difinedSymbol: type)
            C.assign(destination: .d, computation: .m)
            A(constant: index)
            C.assign(destination: .a, computation: .dPlusA)
            C.assign(destination: .d, computation: .m)
            A(difinedSymbol: .sp)
            C.assign(destination: .am, computation: .mPlusOne)
            C.assign(destination: .a, computation: .aMinusOne)
            C.assign(destination: .m, computation: .d)
        }.body
    }
    
}
