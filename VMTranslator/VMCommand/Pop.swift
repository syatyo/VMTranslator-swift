//
//  Pop.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/13.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation


struct Pop: Command {
    let segment: Segment
    let index: Int
    
    var body: String {
        NewAssemblyCommand { () -> String in
            A.symbol(.sp)
            C.assign(destination: .am, computation: .mMinusOne)
            C.assign(destination: .d, computation: .m)
            SegmentCommand(type: .pop, segment: segment, index: index)
            C.assign(destination: .m, computation: .d)
        }.body
    }
    
}

extension Pop: VMCommand {
    
    var assemblyTranslatedCommands: [AssemblyCommand] {
        return [
            A.symbol(.sp),
            C.assign(destination: .am, computation: .mMinusOne),
            C.assign(destination: .d, computation: .m)
        ]
        + segment.popCommands(index: index)
        + [C.assign(destination: .m, computation: .d)]

    }

}
