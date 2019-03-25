//
//  Add.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/24.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Add {
    
    func execute() -> String {
        var builder = CommandBuilder()
        builder.add(AInstruction(difinedSymbol: .sp))
        builder.add(CInstruction.assign(destination: .am, computation: .mMinusOne))
        builder.add(CInstruction.assign(destination: .d, computation: .m))
        builder.add(CInstruction.assign(destination: .a, computation: .aMinusOne))
        builder.add(CInstruction.assign(destination: .m, computation: .dPlusM))
        return builder.build()
    }
    
}

extension Add: AssemblyCommandGeneratable {
    
    func generate() -> String {
        return execute()
    }
    
}
