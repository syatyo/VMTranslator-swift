//
//  Negative.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/25.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Negative { }

extension Negative: VMCommand {
    
    var assemblyTranslatedCommands: [AssemblyCommandGeneratable] {
        return [
            AInstruction(difinedSymbol: .sp),
            CInstruction.assign(destination: .a, computation: .mMinusOne),
            CInstruction.assign(destination: .m, computation: .minusM)
        ]
    }
    
}
