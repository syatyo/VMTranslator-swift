//
//  Not.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/27.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Not {
    
    func execute() -> String {
        var builder = CommandBuilder()
        builder.add(AInstruction(difinedSymbol: .sp))
        builder.add(CInstruction.assign(destination: .a, computation: .mMinusOne))
        builder.add(CInstruction.assign(destination: .m, computation: .notM))
        return builder.build()
    }
    
}

extension Not: AssemblyCommandGeneratable {
    
    func generate() -> String {
        return execute()
    }
    
}
