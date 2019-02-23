//
//  CodeWriter.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/24.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct CodeWriter {
    let outputDirPath: String
    private var fileName: String?
    
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
    
}
