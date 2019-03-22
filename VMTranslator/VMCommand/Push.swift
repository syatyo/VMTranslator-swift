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
    
    // Template method
    func execute() -> String {
        var builder = CommandBuilder()
        builder.add(contentsOf: segment.pushCommands(index: index))
        builder.add(ATCommand(difinedSymbol: .sp))
        builder.add(AssignCommand(destination: .am, computation: .mPlusOne))
        builder.add(AssignCommand(destination: .a, computation: .aMinusOne))
        builder.add(AssignCommand(destination: .m, computation: .d))
        return builder.build()
    }
    
    
}

extension Push: AssemblyCommandGeneratable {
    
    func generate() -> String {
        return execute()
    }
    
}
