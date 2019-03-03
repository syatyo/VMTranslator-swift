//
//  Not.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/27.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Not {
    
    func execute() -> String {
        var builder = CommandBuilder()
        builder.add(ATCommand(difinedSymbol: .sp))
        builder.add(AssignCommand(destination: .a, computation: .mMinusOne))
        builder.add(AssignCommand(destination: .m, computation: .notM))
        return builder.build()
    }
    
}
