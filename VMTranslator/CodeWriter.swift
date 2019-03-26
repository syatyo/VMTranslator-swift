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
    private var vmCommandBuilder = CommandBuilder<VMCommand>()
    var assembly: String {
        return vmCommandBuilder.build()
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
        let segmentValue: Segment = {
            switch segment {
            case "constant":
                return Constant()
            case "argument":
                return Argument()
            case "local":
                return Local()
            case "this":
                return This()
            case "that":
                return That()
            case "pointer":
                return Pointer()
            case "temp":
                return Temp()
            case "static":
                return Static(fileName: fileName!)
            default:
                fatalError()
            }
        }()

        switch commandType {
        case .push:
            let push = Push(segment: segmentValue, index: index)
            vmCommandBuilder.add(push)
        case .pop:
            
            let pop = Pop(segment: segmentValue, index: index)
            vmCommandBuilder.add(pop)
        }
        
    }
    
    mutating func writeArithmetic(command: String) {
        switch command {
        case "add":
            vmCommandBuilder.add(Add())
        case "sub":
            vmCommandBuilder.add(Sub())
        case "neg":
            vmCommandBuilder.add(Negative())
        case "eq":
            var equal = Equal()
            equal.inject(repository: ConditionIndexStore.shared)
            vmCommandBuilder.add(equal)
        case "gt":
            var greater = Greater()
            greater.inject(repository: ConditionIndexStore.shared)
            vmCommandBuilder.add(greater)
        case "lt":
            var less = Less()
            less.inject(repository: ConditionIndexStore.shared)
            vmCommandBuilder.add(less)
        case "and":
            vmCommandBuilder.add(And())
        case "or":
            vmCommandBuilder.add(Or())
        case "not":
            vmCommandBuilder.add(Not())
        default:
            fatalError("Unexpected command.")
        }
    }
    
    mutating func writeLabel(_ labelName: String) {
        vmCommandBuilder.add(Label(name: labelName))
    }
    
    mutating func writeGoto(_ labelName: String) {
        vmCommandBuilder.add(Goto(labelName: labelName))
    }
    
    mutating func writeIf(_ labelName: String) {
        vmCommandBuilder.add(IfGoto(labelName: labelName))
    }
    
}

// Maybe it looks good to make "struct Push" and "struct Pop"
