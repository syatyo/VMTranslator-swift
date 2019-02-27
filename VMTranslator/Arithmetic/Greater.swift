//
//  Greater.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/27.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Greater {
    
    private var symbolCounter = 0
    
    mutating func execute() -> String {
        var lines: [String] = []
        lines.append("@SP")
        lines.append("AM=M-1")
        lines.append("D=M")
        lines.append("A=A-1")
        lines.append("D=M-D")
        lines.append("M=\(Assembly.false)")
        lines.append("@END_GT\(symbolCounter)")
        lines.append("D;JGT")
        lines.append("@SP")
        lines.append("A=M-1")
        lines.append("M=\(Assembly.true)")
        lines.append("(END_GT\(symbolCounter))")
        symbolCounter += 1
        return lines.joined(separator: "\n")
    }
    
}
