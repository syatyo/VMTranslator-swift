//
//  VMTranslator.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/03.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

final class VMTranslator {
    enum Error: Swift.Error {
        case fileOrDirDoesNotExist(atPath: String)
    }
    
    let outputDirectoryPath: String
    let filePaths: [String]
    
    init(path: String) throws {
        
        var isDirectory : ObjCBool = false
        let fileManager = FileManager.default
        
        guard fileManager.fileExists(atPath: path, isDirectory: &isDirectory) else {
            throw Error.fileOrDirDoesNotExist(atPath: path)
        }
        
        if isDirectory.boolValue {
            let url = URL(fileURLWithPath: path)
            let contentsOfDirectory = try fileManager.contentsOfDirectory(at: url,
                                                                          includingPropertiesForKeys: nil,
                                                                          options: [])
            self.filePaths = contentsOfDirectory.map { $0.path }
            self.outputDirectoryPath = path
        } else {
            self.filePaths = [path]
            self.outputDirectoryPath = URL(fileURLWithPath: path).deletingLastPathComponent().path
        }
    }
    
    func startTranslating() throws {
        
        for filePath in self.filePaths {
            try translate(filePath: filePath)
        }
        
    }
    
    private func translate(filePath: String) throws {
        let vmFilePath = URL(fileURLWithPath: filePath).deletingPathExtension().appendingPathExtension("vm").path

        var parser = Parser(vmFilePath: filePath)
        var codeWriter = CodeWriter(outputDirPath: self.outputDirectoryPath)
        codeWriter.setFileName(vmFilePath)
        
        while parser.hasMoreCommands {
            switch parser.commandType {
            case .push:
                codeWriter.writePushPop(.push, segment: parser.arg1, index: parser.arg2)
            case .arithmetic:
                codeWriter.writeArithmetic(command: parser.arg1)
            default:
                fatalError("TODO")
            }
            parser.advance()
        }
        try codeWriter.close() // It means saving.
    }
    
}
