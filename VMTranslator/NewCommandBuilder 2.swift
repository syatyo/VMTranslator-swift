//
//  NewCommandBuilder.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/06/17.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

/// Command is supertype of any command that have string body. It may be asm or vm command.
protocol Command {
    
    /// body of command. It can be single line and multiple line.
    var body: String { get }
    
}

/// FunctionBuilder to build commands in closure
/// - Example: Decrered like this
///
/// ```
/// init(@NewCommandBuilder builder: () -> String) { }
/// ```
///
/// Use like this:
/// ```
/// AssemblyCommand {
///     A.symbol(type)
///     C.assign(destination: .d, computation: .m)
/// }
/// ```
@_functionBuilder struct NewCommandBuilder {
    
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

struct NewPush: Command {
    var index: Int
    var `type`: A.DefinedSymbol
    
    var body: String {
        NewAssemblyCommand {
            A.symbol(type)
            C.assign(destination: .d, computation: .m)
            A.constant(index)
            C.assign(destination: .a, computation: .dPlusA)
            C.assign(destination: .d, computation: .m)
            A.symbol(.sp)
            C.assign(destination: .am, computation: .mPlusOne)
            C.assign(destination: .a, computation: .aMinusOne)
            C.assign(destination: .m, computation: .d)
        }.body
    }
    
}
