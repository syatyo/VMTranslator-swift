//
//  VMTranslator.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/03.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

/// Assembler for translating .vm to .asm. This controls Parser and CodeWriter.
final class VMTranslator {
    
    enum Error: Swift.Error {
        case fileOrDirDoesNotExist(atPath: String)
    }
    
    /// vm file paths for translating.
    let inputFilePaths: [String]
    
    /// dir path for saving asm files.
    let outputDirectoryPath: String
    
    /// Initialize Virtual Machine Translator from file path or directory path.
    /// If you pass file path, translate the file to asembly. else if you pass directory path, search vm files under the directory, then translate them to asm files.
    init(inputPath: String, outputDirectoryPath: String? = nil) throws {
        
        var isDirectory : ObjCBool = false
        let fileManager = FileManager.default
        
        guard fileManager.fileExists(atPath: inputPath, isDirectory: &isDirectory) else {
            throw Error.fileOrDirDoesNotExist(atPath: inputPath)
        }
        
        if isDirectory.boolValue {
            let url = URL(fileURLWithPath: inputPath)
            let contentsOfDirectory = try fileManager.contentsOfDirectory(at: url,
                                                                          includingPropertiesForKeys: nil,
                                                                          options: [])
            self.inputFilePaths = contentsOfDirectory.map { $0.path }
            
            if let outputDir = outputDirectoryPath {
                self.outputDirectoryPath = outputDir
            } else {
                self.outputDirectoryPath = inputPath
            }
        } else {
            self.inputFilePaths = [inputPath]
            if let outputDir = outputDirectoryPath {
                self.outputDirectoryPath = outputDir
            } else {
                self.outputDirectoryPath = URL(fileURLWithPath: inputPath).deletingLastPathComponent().path
            }
        }
    }
    
    /// Start translating to a file or files.
    func startTranslating() throws {
        try inputFilePaths.forEach { try translate(filePath: $0) }
    }
    
    /// Translate vm file to asm file.
    /// - parameter filePath: vm file path.
    private func translate(filePath: String) throws {
        let vmFileURL = URL(fileURLWithPath: filePath)
        let asmFileName = vmFileURL.deletingPathExtension().appendingPathExtension("asm").lastPathComponent
        
        var parser = Parser(vmFilePath: filePath)
        var codeWriter = CodeWriter(outputDirPath: self.outputDirectoryPath)
        codeWriter.setFileName(asmFileName)
        
        while parser.hasMoreCommands {
            switch parser.commandType {
            case .push:
                codeWriter.writePushPop(.push, segment: parser.arg1, index: parser.arg2)
            case .pop:
                codeWriter.writePushPop(.pop, segment: parser.arg1, index: parser.arg2)
            case .arithmetic:
                codeWriter.writeArithmetic(command: parser.arg1)
            case .label:
                codeWriter.writeLabel(parser.arg1)
            case .goto:
                codeWriter.writeGoto(parser.arg1)
            case .if:
                codeWriter.writeIf(parser.arg1)
            default:
                fatalError("TODO")
            }
            parser.advance()
        }
        try codeWriter.close() // It means saving.
    }
    
}
