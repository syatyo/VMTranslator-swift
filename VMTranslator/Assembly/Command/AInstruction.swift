//
//  ATCommand.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/03.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

/// @value command in assembly. It assign given value to A register.
struct AInstruction {
    
    private var value: String
    
    enum DefinedSymbol: String {
        case sp
        case lcl
        case arg
        case this
        case that
    }
    
    init(difinedSymbol: DefinedSymbol) {
        self.value = difinedSymbol.rawValue.uppercased()
    }
    
    init(constant: Int) {
        self.value = constant.description
    }
    
    init(label: String) {
        self.value = label
    }
    
}

extension AInstruction: AssemblyCommand {
    
    func generate() -> String {
        return "@\(value)"
    }
    
}
