//
//  MemoryAccess.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/03.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct MemoryAccess {
    
    func push(segment: SegmentType, index: Int) -> String {
        var lines: [String] = []
        lines.append("@\(index)")
        lines.append(AssignCommand(destination: .d, computation: .a).value)
        lines.append("@SP")
        lines.append(AssignCommand(destination: .am, computation: .mPlusOne).value)
        lines.append(AssignCommand(destination: .a, computation: .aMinusOne).value)
        lines.append(AssignCommand(destination: .m, computation: .d).value)
        return lines.joined(separator: "\n")
    }
    
}
