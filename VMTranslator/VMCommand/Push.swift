//
//  Push.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/13.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Push {
    let segment: Segment
    let index: Int
    
}

extension Push: VMCommand {
    
    var assemblyTranslatedCommands: [AssemblyCommandGeneratable] {
        return segment.pushCommands(index: index) +
        [
            AInstruction(difinedSymbol: .sp),
            CInstruction.assign(destination: .am, computation: .mPlusOne),
            CInstruction.assign(destination: .a, computation: .aMinusOne),
            CInstruction.assign(destination: .m, computation: .d)
        ]
    }
    
}
