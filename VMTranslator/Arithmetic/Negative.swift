//
//  Negative.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/25.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Negative {
    
    func execute() -> String {
        var builder = CommandBuilder()
        builder.add(ATCommand(difinedSymbol: .sp))
        builder.add(AssignCommand(destination: .a, computation: .mMinusOne))
        builder.add(AssignCommand(destination: .m, computation: .minusM))
        return builder.build()
    }

}
