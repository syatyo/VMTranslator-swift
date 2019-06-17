//
//  Or.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/27.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Or { }

extension Or: VMCommand {
    
    var assemblyTranslatedCommands: [AssemblyCommand] {
        return [
            A.symbol(.sp),
            C.assign(destination: .am, computation: .mMinusOne),
            C.assign(destination: .d, computation: .m),
            C.assign(destination: .a, computation: .aMinusOne),
            C.assign(destination: .m, computation: .dOrM)
        ]
    }
    
}
