//
//  Negative.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/25.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Negative {
    
    func execute() -> String {
        var builder = CommandBuilder()
        builder.add(AInstruction(difinedSymbol: .sp))
        builder.add(CInstruction.assign(destination: .a, computation: .mMinusOne))
        builder.add(CInstruction.assign(destination: .m, computation: .minusM))
        return builder.build()
    }

}

extension Negative: AssemblyCommandGeneratable {
    
    func generate() -> String {
        return execute()
    }
    
}
