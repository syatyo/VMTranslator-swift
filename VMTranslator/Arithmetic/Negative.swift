//
//  Negative.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/25.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Negative {
    
    func execute() -> String {
        var lines: [String] = []
        lines.append("@SP")
        lines.append(AssignCommand(destination: .a, computation: .mMinusOne).textRepresentation)
        lines.append(AssignCommand(destination: .m, computation: .minusM).textRepresentation)
        return lines.joined(separator: "\n")
    }

}
