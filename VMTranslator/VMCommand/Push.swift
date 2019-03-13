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
            // Header部？
            builder.add(ATCommand(constant: index))
            builder.add(AssignCommand(destination: .d, computation: .a))
            
            let pushStackIncrementer = PushStackIncrementer()
            return builder.build() + "\n" + pushStackIncrementer.execute()
            
        case .local:
            var builder = CommandBuilder()
            // Header部？
            builder.add(ATCommand(difinedSymbol: .lcl))
            builder.add(AssignCommand(destination: .d, computation: .a))
            builder.add(ATCommand(constant: index))
            builder.add(AssignCommand(destination: .d, computation: .dPlusA))
            
            let pushStackIncrementer = PushStackIncrementer()
            return builder.build() + "\n" + pushStackIncrementer.execute()
            
        case .argument:
            var builder = CommandBuilder()
            // Header部？
            builder.add(ATCommand(difinedSymbol: .arg))
            builder.add(AssignCommand(destination: .d, computation: .a))
            builder.add(ATCommand(constant: index))
            builder.add(AssignCommand(destination: .d, computation: .dPlusA))
            
            let pushStackIncrementer = PushStackIncrementer()
            return builder.build() + "\n" + pushStackIncrementer.execute()
            
        case .this:
            var builder = CommandBuilder()
            // Header部？
            builder.add(ATCommand(difinedSymbol: .this))
            builder.add(AssignCommand(destination: .d, computation: .a))
            builder.add(ATCommand(constant: index))
            builder.add(AssignCommand(destination: .d, computation: .dPlusA))
            
            let pushStackIncrementer = PushStackIncrementer()
            return builder.build() + "\n" + pushStackIncrementer.execute()

        case .that:
            var builder = CommandBuilder()
            // Header部？
            builder.add(ATCommand(difinedSymbol: .that))
            builder.add(AssignCommand(destination: .d, computation: .a))
            builder.add(ATCommand(constant: index))
            builder.add(AssignCommand(destination: .d, computation: .dPlusA))
            
            let pushStackIncrementer = PushStackIncrementer()
            return builder.build() + "\n" + pushStackIncrementer.execute()

        default:
            fatalError()
        }
    }
    
    
}
