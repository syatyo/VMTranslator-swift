//
//  CodeWriter.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/24.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

enum MemoryAccessCommandType {
    case push
    case pop
}

enum SegmentType {
    case argument
    case local
    case `static`
    case constant
    case this
    case that
    case pointer
    case temp
}

struct CodeWriter {
    let outputDirPath: String
    private var fileName: String?
    private var assemblyCommands: [String] = []
    var assembly: String {
        return assemblyCommands.joined(separator: "\n")
    }
    
    private enum Symbol: String {
        case sp = "SP"
        case lcl = "LCL"
        case arg = "ARG"
        case this = "THIS"
        case that = "THAT"
        
        var aInstraction: String {
            return "@\(rawValue)"
        }
        
    }
    
    init(outputDirPath: String) {
        self.outputDirPath = outputDirPath
    }
    
    mutating func setFileName(_ fileName: String) {
        self.fileName = fileName
    }
    
    var outputFilePath: String? {
        guard let fileName = self.fileName else { return nil }
        return outputDirPath + fileName
    }
    
    func close() throws {
        let url = URL(fileURLWithPath: outputFilePath ?? "")
        try assembly.write(to: url, atomically: false, encoding: .utf8)
    }
    
    mutating func writePushPop(_ commandType: MemoryAccessCommandType,
                               segmentType: SegmentType,
                               index: Int) {
        let ma = MemoryAccess()
        assemblyCommands.append(ma.push(segment: .constant, index: index))
    }
    
    mutating func writeArithmetic(command: String) {
        switch command {
        case "add":
            assemblyCommands.append(Add().execute())
        case "sub":
            assemblyCommands.append(Sub().execute())
        case "neg":
            assemblyCommands.append(Negative().execute())
        case "eq":
            assemblyCommands.append(Equal().execute())
        case "gt":
            assemblyCommands.append(Greater().execute())
        case "lt":
            assemblyCommands.append(Less().execute())
        case "and":
            assemblyCommands.append(And().execute())
        case "or":
            assemblyCommands.append(Or().execute())
        case "not":
            assemblyCommands.append(Not().execute())
        default:
            fatalError("Unexpected command.")
        }
    }
    
}

// Maybe it looks good to make "struct Push" and "struct Pop"
