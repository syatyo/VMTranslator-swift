//
//  PopStackDecrementer.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/13.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct PopStackDecrementer {

    func execute() -> String {
        var builder = CommandBuilder()
        builder.add(ATCommand(difinedSymbol: .sp))
        builder.add(AssignCommand(destination: .am, computation: .mMinusOne))
        builder.add(AssignCommand(destination: .m, computation: .d))
        return builder.build()
    }
}

extension PopStackDecrementer: AssemblyCommandGeneratable {
    
    func generate() -> String {
        return execute()
    }
    
}
