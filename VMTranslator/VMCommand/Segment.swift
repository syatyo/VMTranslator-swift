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
    func execute() -> String
}

protocol RegisterDefined {
    var `type`: ATCommand.DefinedSymbol { get }
}

extension Segment where Self: RegisterDefined {
    
    func execute() -> String {
        var builder = CommandBuilder()
        builder.add(ATCommand(difinedSymbol: type))
        builder.add(AssignCommand(destination: .d, computation: .m))
        builder.add(ATCommand(constant: index))
        builder.add(AssignCommand(destination: .d, computation: .dPlusA))
        return builder.build()
    }
    
}

struct Local: Segment, RegisterDefined, AssemblyCommandGeneratable {
    var type: ATCommand.DefinedSymbol { return .lcl }
    let index: Int
    
    func generate() -> String {
        return execute()
    }

}

struct Argument: Segment, RegisterDefined, AssemblyCommandGeneratable {
    var type: ATCommand.DefinedSymbol { return .arg }
    let index: Int
    
    func generate() -> String {
        return execute()
    }
}

struct This: Segment, RegisterDefined, AssemblyCommandGeneratable {
    var type: ATCommand.DefinedSymbol { return .this }
    let index: Int
    
    func generate() -> String {
        return execute()
    }
}

struct That: Segment, RegisterDefined, AssemblyCommandGeneratable {
    var type: ATCommand.DefinedSymbol { return .that }
    let index: Int
    
    func generate() -> String {
        return execute()
    }
}

struct Pointer: Segment, AssemblyCommandGeneratable {
    let index: Int
    private let baseAddress: Int = 3
    
    func execute() -> String {
        var builder = CommandBuilder()
        builder.add(ATCommand(constant: baseAddress))
        builder.add(AssignCommand(destination: .d, computation: .m))
        builder.add(ATCommand(constant: index))
        builder.add(AssignCommand(destination: .d, computation: .dPlusA))
        return builder.build()
    }

    func generate() -> String {
        return execute()
    }
    
}

struct Temp: Segment, AssemblyCommandGeneratable {
    var index: Int
    private let baseAddress: Int = 5
    
    func execute() -> String {
        var builder = CommandBuilder()
        builder.add(ATCommand(constant: baseAddress))
        builder.add(AssignCommand(destination: .d, computation: .m))
        builder.add(ATCommand(constant: index))
        builder.add(AssignCommand(destination: .d, computation: .dPlusA))
        return builder.build()
    }
    
    func generate() -> String {
        return execute()
    }
    
}
