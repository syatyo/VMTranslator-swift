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
        lines.append(AssignCommand(destination: .d, computation: .a).textRepresentation)
        lines.append("@SP")
        lines.append(AssignCommand(destination: .am, computation: .mPlusOne).textRepresentation)
        lines.append(AssignCommand(destination: .a, computation: .aMinusOne).textRepresentation)
        lines.append(AssignCommand(destination: .m, computation: .d).textRepresentation)
        return lines.joined(separator: "\n")
    }
    
}
