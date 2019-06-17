//
//  A.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/06/17.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

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
