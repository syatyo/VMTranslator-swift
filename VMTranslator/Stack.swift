//
//  Stack.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/06/23.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct WorkingStack {
    
    private var commands: [Command] = []
    
    var body: String {
        commands
            .map { $0.body }
            .joined(separator: "\n")
    }
    
    mutating func push(segment: Segment, index: Int) {
        commands.append(SegmentCommand(type: .push, segment: segment, index: index))
        commands.append(A.symbol(.sp))
        commands.append(C.assign(destination: .am, computation: .mPlusOne))
        commands.append(C.assign(destination: .a, computation: .aMinusOne))
        commands.append(C.assign(destination: .m, computation: .d))
    }
    
    mutating func pop(segment: Segment, index: Int) {
        commands.append(A.symbol(.sp))
        commands.append(C.assign(destination: .am, computation: .mMinusOne))
        commands.append(C.assign(destination: .d, computation: .m))
        commands.append(SegmentCommand(type: .pop, segment: segment, index: index))
        commands.append(C.assign(destination: .m, computation: .d))
    }
    
}

private extension SegmentType {
    
    var symbol: A.DefinedSymbol {
        switch self {
        case .local:
            return .lcl
        case .argument:
            return .arg
        case .this:
            return .this
        case .that:
            return .that
        default:
            fatalError()
        }
    }
}
