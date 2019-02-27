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
        return build(from: ["M=M+1"])
    }
    
    func decrement() -> String {
        return build(from: ["M=M-1"])
    }
    
    func makeARegisterPointFirstArgument() -> String {
        return build(from: ["A=M-1"])
    }
    
    func makeARegisterPointSecondArgument() -> String {
        return build(from: ["A=M-1",
                            "A=A-1"])
    }
    
    private func build(from commands: [String]) -> String {
        var lines: [String] = [StackPointer.instruction]
        lines.append(contentsOf: commands)
        return lines.joined(separator: "\n")
    }
    
}
