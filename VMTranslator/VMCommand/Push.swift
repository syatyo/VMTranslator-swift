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
            builder.add(contentsOf: Local(index: index).pushCommands())
            builder.add(PushStackIncrementer())
            return builder.build()
            
        case .argument:
            var builder = CommandBuilder()
            builder.add(contentsOf: Argument(index: index).pushCommands())
            builder.add(PushStackIncrementer())
            return builder.build()
            
        case .this:
            var builder = CommandBuilder()
            builder.add(contentsOf: This(index: index).pushCommands())
            builder.add(PushStackIncrementer())
            return builder.build()
            
        case .that:
            var builder = CommandBuilder()
            builder.add(contentsOf: That(index: index).pushCommands())
            builder.add(PushStackIncrementer())
            return builder.build()
            
        case .pointer:
            var builder = CommandBuilder()
            builder.add(contentsOf: Pointer(index: index).pushCommands())
            builder.add(PushStackIncrementer())
            return builder.build()

        case .temp:
            var builder = CommandBuilder()
            builder.add(contentsOf: Temp(index: index).pushCommands())
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
