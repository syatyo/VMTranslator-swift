//
//  Pop.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/13.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

private extension SegmentType {
    
    var symbol: A.DefinedSymbol {
        switch self {
        case .local:
            return .lcl
        case .argument:
            return .arg
        case .this:
            return .this
        case .that:
            return .that
        default:
            fatalError()
        }
    }
}

struct Pop {
    let segment: Segment
    let index: Int
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
