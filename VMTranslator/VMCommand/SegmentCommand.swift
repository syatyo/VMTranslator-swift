//
//  SegmentCommand.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/06/18.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct SegmentCommand: Command {
    let `type`: MemoryAccessCommandType
    let segment: Segment
    let index: Int
    
    var body: String {
        switch type {
        case .push:
            return segment.pushCommands(index: index)
                .map { $0.generate() }
                .joined(separator: "\n")
        case .pop:
            return segment.popCommands(index: index)
                .map { $0.generate() }
                .joined(separator: "\n")
        }
    }
}
