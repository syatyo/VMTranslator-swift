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
            
            // SP部？
            builder.add(ATCommand(difinedSymbol: .sp))
            builder.add(AssignCommand(destination: .am, computation: .mPlusOne))
            builder.add(AssignCommand(destination: .a, computation: .aMinusOne))
            builder.add(AssignCommand(destination: .m, computation: .d))
            return builder.build()
            
        case .local:
            var builder = CommandBuilder()
            // Header部？
            builder.add(ATCommand(difinedSymbol: .lcl))
            builder.add(AssignCommand(destination: .d, computation: .a))
            builder.add(ATCommand(constant: index))
            builder.add(AssignCommand(destination: .d, computation: .dPlusA))
            
            // SP部？
            builder.add(ATCommand(difinedSymbol: .sp))
            builder.add(AssignCommand(destination: .am, computation: .mPlusOne))
            builder.add(AssignCommand(destination: .a, computation: .aMinusOne))
            builder.add(AssignCommand(destination: .m, computation: .d))
            return builder.build()
            
        case .argument:
            var builder = CommandBuilder()
            // Header部？
            builder.add(ATCommand(difinedSymbol: .arg))
            builder.add(AssignCommand(destination: .d, computation: .a))
            builder.add(ATCommand(constant: index))
            builder.add(AssignCommand(destination: .d, computation: .dPlusA))
            
            // SP部？
            builder.add(ATCommand(difinedSymbol: .sp))
            builder.add(AssignCommand(destination: .am, computation: .mPlusOne))
            builder.add(AssignCommand(destination: .a, computation: .aMinusOne))
            builder.add(AssignCommand(destination: .m, computation: .d))
            return builder.build()
        default:
            fatalError()
        }
    }
    
    
}
