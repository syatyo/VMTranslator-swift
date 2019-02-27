//
//  Not.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/27.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Not {
    
    func execute() -> String {
        var lines: [String] = []
        lines.append("@SP")
        lines.append("A=M-1")
        lines.append("M=!M")
        return lines.joined(separator: "\n")
    }
    
}
