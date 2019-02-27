//
//  And.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/27.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct And {
    
    func execute() -> String {
        var lines: [String] = []
        lines.append("@SP")
        lines.append(AssignCommand(destination: .am, computation: .mMinusOne).value)
        lines.append(AssignCommand(destination: .d, computation: .m).value)
        lines.append(AssignCommand(destination: .a, computation: .aMinusOne).value)
        lines.append(AssignCommand(destination: .m, computation: .dAndM).value)
        return lines.joined(separator: "\n")
    }
    
}
