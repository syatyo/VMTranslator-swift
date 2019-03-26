//
//  Not.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/27.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Not { }

extension Not: VMCommand {
    
    var assemblyTranslatedCommands: [AssemblyCommandGeneratable] {
        return [
            AInstruction(difinedSymbol: .sp),
            CInstruction.assign(destination: .a, computation: .mMinusOne),
            CInstruction.assign(destination: .m, computation: .notM)
        ]
    }
    
}
