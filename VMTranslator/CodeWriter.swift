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

enum SegmentType: String {
    case argument
    case local
    case `static` = "static"
    case constant
    case this
    case that
    case pointer
    case temp
}

struct CodeWriter {
    private let outputDirURL: URL
    var outputFilePath: String {
        return outputDirURL.path
    }
    
    private(set) var fileName: String?
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
    
    enum Error: Swift.Error {
        case noFileName
        
        var localizedDescription: String {
            switch self {
            case .noFileName:
                return "Filename is not set. Please set filename before calling translation."
            }
        }
    }
    
    init(outputDirPath: String) {
        self.outputDirURL = URL(string: outputDirPath)!
    }
    
    mutating func setFileName(_ fileName: String) {
        self.fileName = fileName
    }
    
    func close() throws {
        guard let fileName = self.fileName else {
            throw Error.noFileName
        }
        
        let outputFilePath = outputDirURL.appendingPathComponent(fileName).path
        try assembly.write(toFile: outputFilePath, atomically: false, encoding: .utf8)
    }
    
    mutating func writePushPop(_ commandType: MemoryAccessCommandType,
                               segment: String,
                               index: Int) {
        let segmentType = SegmentType(rawValue: segment)!
        let ma = MemoryAccess()
        assemblyCommands.append(ma.push(segment: segmentType, index: index))
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
            var equal = Equal()
            equal.inject(repository: ConditionIndexStore.shared)
            assemblyCommands.append(equal.execute())
        case "gt":
            var greater = Greater()
            greater.inject(repository: ConditionIndexStore.shared)
            assemblyCommands.append(greater.execute())
        case "lt":
            var less = Less()
            less.inject(repository: ConditionIndexStore.shared)
            assemblyCommands.append(less.execute())
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
