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
            
            let pushStackIncrementer = PushStackIncrementer()
            return builder.build() + "\n" + pushStackIncrementer.execute()
            
        case .local:
            let local = Local(index: index)
            let pushStackIncrementer = PushStackIncrementer()
            return local.execute() + "\n" + pushStackIncrementer.execute()
            
        case .argument:
            let argument = Argument(index: index)
            let pushStackIncrementer = PushStackIncrementer()
            return argument.execute() + "\n" + pushStackIncrementer.execute()
            
        case .this:
            let this = This(index: index)
            let pushStackIncrementer = PushStackIncrementer()
            return this.execute() + "\n" + pushStackIncrementer.execute()

        case .that:
            let that = That(index: index)
            let pushStackIncrementer = PushStackIncrementer()
            return that.execute() + "\n" + pushStackIncrementer.execute()

        default:
            fatalError()
        }
    }
    
    
}
