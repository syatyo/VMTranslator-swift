//
//  Push.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/13.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Push {
    let segment: SegmentType
    let index: Int
    
    func execute() -> String {
        switch segment {
        case .constant:
            var builder = CommandBuilder()
            builder.add(ATCommand(constant: index))
            builder.add(AssignCommand(destination: .d, computation: .a))
            builder.add(PushStackIncrementer())
            return builder.build()
            
        case .local:
            var builder = CommandBuilder()
            builder.add(contentsOf: Local().pushCommands(index: index))
            builder.add(PushStackIncrementer())
            return builder.build()
            
        case .argument:
            var builder = CommandBuilder()
            builder.add(contentsOf: Argument().pushCommands(index: index))
            builder.add(PushStackIncrementer())
            return builder.build()
            
        case .this:
            var builder = CommandBuilder()
            builder.add(contentsOf: This().pushCommands(index: index))
            builder.add(PushStackIncrementer())
            return builder.build()
            
        case .that:
            var builder = CommandBuilder()
            builder.add(contentsOf: That().pushCommands(index: index))
            builder.add(PushStackIncrementer())
            return builder.build()
            
        case .pointer:
            var builder = CommandBuilder()
            builder.add(contentsOf: Pointer().pushCommands(index: index))
            builder.add(PushStackIncrementer())
            return builder.build()

        case .temp:
            var builder = CommandBuilder()
            builder.add(contentsOf: Temp().pushCommands(index: index))
            builder.add(PushStackIncrementer())
            return builder.build()

        default:
            fatalError()
        }
    }
    
    
}

extension Push: AssemblyCommandGeneratable {
    
    func generate() -> String {
        return execute()
    }
    
}
