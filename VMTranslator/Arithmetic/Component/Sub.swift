//
//  Sub.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/24.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Sub { }

extension Sub: VMCommand {
    
    var assemblyTranslatedCommands: [AssemblyCommandGeneratable] {
        return [
            AInstruction(difinedSymbol: .sp),
            CInstruction.assign(destination: .am, computation: .mMinusOne),
            CInstruction.assign(destination: .d, computation: .m),
            CInstruction.assign(destination: .a, computation: .aMinusOne),
            CInstruction.assign(destination: .m, computation: .mMinusD)
        ]
    }
    
}
