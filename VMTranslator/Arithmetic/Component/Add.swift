//
//  Add.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/24.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Add {
    
    func execute() -> String {
        var builder = CommandBuilder()
        builder.add(ATCommand(difinedSymbol: .sp))
        builder.add(AssignCommand(destination: .am, computation: .mMinusOne))
        builder.add(AssignCommand(destination: .d, computation: .m))
        builder.add(AssignCommand(destination: .a, computation: .aMinusOne))
        builder.add(AssignCommand(destination: .m, computation: .dPlusM))
        return builder.build()
    }
    
}

extension Add: AssemblyCommandGeneratable {
    
    func generate() -> String {
        return execute()
    }
    
}
