//
//  Pop.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/13.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

private extension SegmentType {
    var symbol: ATCommand.DefinedSymbol {
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
    
    // Template method
    func execute() -> String {
        var builder = CommandBuilder()
        builder.add(ATCommand(difinedSymbol: .sp))
        builder.add(CInstruction.assign(destination: .am, computation: .mMinusOne))
        builder.add(CInstruction.assign(destination: .d, computation: .m))
        builder.add(contentsOf: segment.popCommands(index: index))
        builder.add(CInstruction.assign(destination: .m, computation: .d))
        return builder.build()
    }

}

extension Pop: AssemblyCommandGeneratable {
    
    func generate() -> String {
        return execute()
    }
    
}
