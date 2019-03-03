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
        lines.append(AssignCommand(destination: .am, computation: .mMinusOne).textRepresentation)
        lines.append(AssignCommand(destination: .d, computation: .m).textRepresentation)
        lines.append(AssignCommand(destination: .a, computation: .aMinusOne).textRepresentation)
        lines.append(AssignCommand(destination: .m, computation: .dAndM).textRepresentation)
        return lines.joined(separator: "\n")
    }
    
}
