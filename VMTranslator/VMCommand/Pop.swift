//
//  Pop.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/13.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Pop {
    let segment: SegmentType
    let index: Int

    func execute() -> String {
        
        switch segment {
        case .constant:
            fatalError("Constant segment is only for push.")
            
        case .local:
            var builder = CommandBuilder()
            builder.add(Local(index: index))
            builder.add(PopStackDecrementer())
            return builder.build()

        case .argument:
            var builder = CommandBuilder()
            builder.add(Argument(index: index))
            builder.add(PopStackDecrementer())
            return builder.build()

        case .this:
            var builder = CommandBuilder()
            builder.add(This(index: index))
            builder.add(PopStackDecrementer())
            return builder.build()

        case .that:
            var builder = CommandBuilder()
            builder.add(That(index: index))
            builder.add(PopStackDecrementer())
            return builder.build()
            
        case .pointer:
            var builder = CommandBuilder()
            builder.add(Pointer(index: index))
            builder.add(PopStackDecrementer())
            return builder.build()
        
        case .temp:
            var builder = CommandBuilder()
            builder.add(Temp(index: index))
            builder.add(PopStackDecrementer())
            return builder.build()
            
        default:
            fatalError()
        }
    }

}

extension Pop: AssemblyCommandGeneratable {
    
    func generate() -> String {
        return execute()
    }
    
}
