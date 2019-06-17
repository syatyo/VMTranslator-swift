//
//  A.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/06/17.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

/// @value command in assembly. It assign given value to A register.
enum A: Command {
    
    typealias Body = String
    var body: String {
        switch self {
        case .symbol(let symbol):
            return "@\(symbol.rawValue.uppercased())"
            
        case .constant(let constant):
            return "@\(constant.description)"
            
        case .label(let label):
            return "@\(label)"
        }
    }
    
    enum DefinedSymbol: String {
        case sp
        case lcl
        case arg
        case this
        case that
    }
    
    /// A symbol is defined in Hack platform
    /// - Example: @SP
    case symbol(DefinedSymbol)
    
    /// Constant value
    /// - Example: @10
    case constant(Int)
    
    /// Label for conditions or stack methods.
    /// - Example: @LOOP_START
    case label(String)
    
}

extension A: AssemblyCommand {
    
    func generate() -> String {
        body
    }
    
}
