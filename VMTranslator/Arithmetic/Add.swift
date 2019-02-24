//
//  Add.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/24.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Add {
    
    func execute() -> String {
        var lines: [String] = []
        lines.append("@SP")
        lines.append("A=M-1")
        lines.append("D=M")
        lines.append("A=A-1")
        lines.append("D=D+M")
        lines.append("M=D")
        lines.append("@SP")
        lines.append("M=M-1")
        return lines.joined(separator: "\n")
    }
    
}
