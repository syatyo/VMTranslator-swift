//
//  StackPointer.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/24.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

// This must be inefficient. but simple is worth for me now.
struct StackPointer {
    static let instruction = "@SP"
    
    func increment() -> String {
        var lines: [String] = [StackPointer.instruction]
        lines.append("M=M+1")
        return lines.joined(separator: "\n")
    }
    
    func decrement() -> String {
        var lines: [String] = [StackPointer.instruction]
        lines.append("M=M-1")
        return lines.joined(separator: "\n")
    }
    
    func pointFirstArgument() -> String {
        var lines: [String] = [StackPointer.instruction]
        lines.append("A=M-1")
        return lines.joined(separator: "\n")
    }
    
    func pointSecondArgument() -> String {
        var lines: [String] = [StackPointer.instruction]
        lines.append("A=M-1")
        lines.append("A=A-1")
        return lines.joined(separator: "\n")
    }
    
}
