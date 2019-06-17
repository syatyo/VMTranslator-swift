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
    
    var assemblyTranslatedCommands: [AssemblyCommand] {
        return segment.pushCommands(index: index) +
        [
            A.symbol(.sp),
            C.assign(destination: .am, computation: .mPlusOne),
            C.assign(destination: .a, computation: .aMinusOne),
            C.assign(destination: .m, computation: .d)
        ]
    }
    
}
