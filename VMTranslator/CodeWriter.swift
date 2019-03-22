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
    private var assemblyCommandBuilder = CommandBuilder()
    var assembly: String {
        return assemblyCommandBuilder.build()
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
        switch commandType {
        case .push:
            let push = Push(segment: segmentType, index: index)
            assemblyCommandBuilder.add(push)
        case .pop:
            let segmentValue: Segment = {
                switch segment {
                case "argument":
                    return Argument(index: index)
                case "local":
                    return Local(index: index)
                case "this":
                    return This(index: index)
                case "that":
                    return That(index: index)
                case "pointer":
                    return Pointer(index: index)
                case "temp":
                    return Temp(index: index)
                default:
                    fatalError()
                }
            }()
            let pop = Pop(segment: segmentValue)
            assemblyCommandBuilder.add(pop)
        }
        
    }
    
    mutating func writeArithmetic(command: String) {
        switch command {
        case "add":
            assemblyCommandBuilder.add(Add())
        case "sub":
            assemblyCommandBuilder.add(Sub())
        case "neg":
            assemblyCommandBuilder.add(Negative())
        case "eq":
            var equal = Equal()
            equal.inject(repository: ConditionIndexStore.shared)
            assemblyCommandBuilder.add(equal)
        case "gt":
            var greater = Greater()
            greater.inject(repository: ConditionIndexStore.shared)
            assemblyCommandBuilder.add(greater)
        case "lt":
            var less = Less()
            less.inject(repository: ConditionIndexStore.shared)
            assemblyCommandBuilder.add(less)
        case "and":
            assemblyCommandBuilder.add(And())
        case "or":
            assemblyCommandBuilder.add(Or())
        case "not":
            assemblyCommandBuilder.add(Not())
        default:
            fatalError("Unexpected command.")
        }
    }
    
}

// Maybe it looks good to make "struct Push" and "struct Pop"
