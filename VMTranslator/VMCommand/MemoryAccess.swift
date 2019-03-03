//
//  MemoryAccess.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/03.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct MemoryAccess {
    
    func push(segment: SegmentType, index: Int) -> String {
        var builder = CommandBuilder()
        builder.add(ATCommand(constant: index))
        builder.add(AssignCommand(destination: .d, computation: .a))
        builder.add(ATCommand(difinedSymbol: .sp))
        builder.add(AssignCommand(destination: .am, computation: .mPlusOne))
        builder.add(AssignCommand(destination: .a, computation: .aMinusOne))
        builder.add(AssignCommand(destination: .m, computation: .d))
        return builder.build()
    }
    
}
