//
//  Negative.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/25.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Negative: Command {
    
    var body: String {
        NewAssemblyCommand {
            A.symbol(.sp)
            C.assign(destination: .a, computation: .mMinusOne)
            C.assign(destination: .m, computation: .minusM)
        }.body
    }
    
}

extension Negative: VMCommand {
    
    var assemblyTranslatedCommands: [AssemblyCommand] {
        return [
            A.symbol(.sp),
            C.assign(destination: .a, computation: .mMinusOne),
            C.assign(destination: .m, computation: .minusM)
        ]
    }
    
}
