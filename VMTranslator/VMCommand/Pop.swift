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
            builder.add(ATCommand(difinedSymbol: .sp))
            builder.add(AssignCommand(destination: .am, computation: .mMinusOne))
            builder.add(AssignCommand(destination: .d, computation: .m))
            builder.add(ATCommand(difinedSymbol: .lcl))
            builder.add(AssignCommand(destination: .a, computation: .m))
            (0..<index).forEach { _ in
                builder.add(AssignCommand(destination: .a, computation: .aPlusOne))
            }
            builder.add(AssignCommand(destination: .m, computation: .d))
            return builder.build()

        case .argument:
            var builder = CommandBuilder()
            builder.add(ATCommand(difinedSymbol: .sp))
            builder.add(AssignCommand(destination: .am, computation: .mMinusOne))
            builder.add(AssignCommand(destination: .d, computation: .m))
            builder.add(ATCommand(difinedSymbol: .arg))
            builder.add(AssignCommand(destination: .a, computation: .m))
            (0..<index).forEach { _ in
                builder.add(AssignCommand(destination: .a, computation: .aPlusOne))
            }
            builder.add(AssignCommand(destination: .m, computation: .d))
            return builder.build()

        case .this:
            var builder = CommandBuilder()
            builder.add(ATCommand(difinedSymbol: .sp))
            builder.add(AssignCommand(destination: .am, computation: .mMinusOne))
            builder.add(AssignCommand(destination: .d, computation: .m))
            builder.add(ATCommand(difinedSymbol: .this))
            builder.add(AssignCommand(destination: .a, computation: .m))
            (0..<index).forEach { _ in
                builder.add(AssignCommand(destination: .a, computation: .aPlusOne))
            }
            builder.add(AssignCommand(destination: .m, computation: .d))
            return builder.build()

        case .that:
            var builder = CommandBuilder()
            builder.add(ATCommand(difinedSymbol: .sp))
            builder.add(AssignCommand(destination: .am, computation: .mMinusOne))
            builder.add(AssignCommand(destination: .d, computation: .m))
            builder.add(ATCommand(difinedSymbol: .that))
            builder.add(AssignCommand(destination: .a, computation: .m))
            (0..<index).forEach { _ in
                builder.add(AssignCommand(destination: .a, computation: .aPlusOne))
            }
            builder.add(AssignCommand(destination: .m, computation: .d))
            return builder.build()

        case .pointer:
            var builder = CommandBuilder()
            builder.add(ATCommand(difinedSymbol: .sp))
            builder.add(AssignCommand(destination: .am, computation: .mMinusOne))
            builder.add(AssignCommand(destination: .d, computation: .m))
            if index == 0 {
                builder.add(ATCommand(difinedSymbol: .this))
            } else if index == 1 {
                builder.add(ATCommand(difinedSymbol: .that))
            }
            builder.add(AssignCommand(destination: .m, computation: .d))
            return builder.build()

        case .temp:
            var builder = CommandBuilder()
            builder.add(ATCommand(difinedSymbol: .sp))
            builder.add(AssignCommand(destination: .am, computation: .mMinusOne))
            builder.add(AssignCommand(destination: .d, computation: .m))
            let label = "R\(5 + index)"
            builder.add(ATCommand(label: label))
            builder.add(AssignCommand(destination: .m, computation: .d))
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
