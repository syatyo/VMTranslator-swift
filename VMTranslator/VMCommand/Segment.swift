//
//  Segment.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/13.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Local {
    let index: Int
    
    func execute() -> String {
        var builder = CommandBuilder()
        builder.add(ATCommand(difinedSymbol: .lcl))
        builder.add(AssignCommand(destination: .d, computation: .a))
        builder.add(ATCommand(constant: index))
        builder.add(AssignCommand(destination: .d, computation: .dPlusA))
        return builder.build()
    }
}

struct Argument {
    let index: Int

    func execute() -> String {
        var builder = CommandBuilder()
        builder.add(ATCommand(difinedSymbol: .arg))
        builder.add(AssignCommand(destination: .d, computation: .a))
        builder.add(ATCommand(constant: index))
        builder.add(AssignCommand(destination: .d, computation: .dPlusA))
        return builder.build()
    }
}

struct This {
    let index: Int
    
    func execute() -> String {
        var builder = CommandBuilder()
        builder.add(ATCommand(difinedSymbol: .this))
        builder.add(AssignCommand(destination: .d, computation: .a))
        builder.add(ATCommand(constant: index))
        builder.add(AssignCommand(destination: .d, computation: .dPlusA))
        return builder.build()
    }
    
}

struct That {
    let index: Int
    
    func execute() -> String {
        var builder = CommandBuilder()
        builder.add(ATCommand(difinedSymbol: .that))
        builder.add(AssignCommand(destination: .d, computation: .a))
        builder.add(ATCommand(constant: index))
        builder.add(AssignCommand(destination: .d, computation: .dPlusA))
        return builder.build()
    }
}
