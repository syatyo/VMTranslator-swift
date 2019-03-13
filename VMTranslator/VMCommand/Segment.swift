//
//  Segment.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/13.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

protocol Segment {
    var index: Int { get }
    var `type`: ATCommand.DefinedSymbol { get }
    func execute() -> String
}

extension Segment {
    
    func execute() -> String {
        var builder = CommandBuilder()
        builder.add(ATCommand(difinedSymbol: type))
        builder.add(AssignCommand(destination: .d, computation: .a))
        builder.add(ATCommand(constant: index))
        builder.add(AssignCommand(destination: .d, computation: .dPlusA))
        return builder.build()
    }
    
}

struct Local: Segment {
    var type: ATCommand.DefinedSymbol { return .lcl }
    let index: Int
    
}

struct Argument: Segment {
    var type: ATCommand.DefinedSymbol { return .arg }
    let index: Int
}

struct This: Segment {
    var type: ATCommand.DefinedSymbol { return .this }
    let index: Int
}

struct That: Segment {
    var type: ATCommand.DefinedSymbol { return .that }
    let index: Int
}
