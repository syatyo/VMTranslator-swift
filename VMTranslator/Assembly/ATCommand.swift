//
//  ATCommand.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/03.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

/// @value command in assembly. It assign given value to A register.
struct ATCommand {
    
    private var command: String
    
    enum DefinedSymbol: String {
        case sp
        case lcl
        case arg
        case this
        case that
    }
    
    init(difinedSymbol: DefinedSymbol) {
        self.command = "@\(difinedSymbol.rawValue.uppercased())"
    }
    
    init(constant: Int) {
        self.command = "@\(constant)"
    }
    
}

extension ATCommand: AssemblyCommand {
    
    var textRepresentation: String {
        return command
    }
    
}
