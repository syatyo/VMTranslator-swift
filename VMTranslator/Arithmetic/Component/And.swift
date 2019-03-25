//
//  And.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/27.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct And {
    
    func execute() -> String {
        var builder = CommandBuilder()
        builder.add(ATCommand(difinedSymbol: .sp))
        builder.add(CInstruction.assign(destination: .am, computation: .mMinusOne))
        builder.add(CInstruction.assign(destination: .d, computation: .m))
        builder.add(CInstruction.assign(destination: .a, computation: .aMinusOne))
        builder.add(CInstruction.assign(destination: .m, computation: .dAndM))
        return builder.build()
    }
    
}

extension And: AssemblyCommandGeneratable {
    
    func generate() -> String {
        return execute()
    }
    
}
