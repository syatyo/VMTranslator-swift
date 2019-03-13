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
            let local = Local(index: index)
            
            builder.add(ATCommand(difinedSymbol: .sp))
            builder.add(AssignCommand(destination: .am, computation: .mMinusOne))
            builder.add(AssignCommand(destination: .m, computation: .d))
            return local.execute() + "\n" + builder.build()

        case .argument:
            var builder = CommandBuilder()
            let argument = Argument(index: index)
            builder.add(ATCommand(difinedSymbol: .sp))
            builder.add(AssignCommand(destination: .am, computation: .mMinusOne))
            builder.add(AssignCommand(destination: .m, computation: .d))
            return argument.execute() + "\n" + builder.build()

        case .this:
            var builder = CommandBuilder()
            let this = This(index: index)
            builder.add(ATCommand(difinedSymbol: .sp))
            builder.add(AssignCommand(destination: .am, computation: .mMinusOne))
            builder.add(AssignCommand(destination: .m, computation: .d))
            return this.execute() + "\n" + builder.build()

        case .that:
            var builder = CommandBuilder()
            let that = That(index: index)
            builder.add(ATCommand(difinedSymbol: .sp))
            builder.add(AssignCommand(destination: .am, computation: .mMinusOne))
            builder.add(AssignCommand(destination: .m, computation: .d))
            return that.execute() + "\n" + builder.build()
            
        default:
            fatalError()
        }
    }

}
