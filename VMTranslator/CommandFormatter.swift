//
//  commnadFormatter.swift
//  HackAssembler
//
//  Created by 山田良治 on 2019/01/09.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

final class CommandFormatter {
    var text: String {
        return lines.joined(separator: "\n")
    }
    private var lines: [String]
    
    init(source: String) {
        self.lines = source
            .replacingOccurrences(of: "\r", with: "")
            .components(separatedBy: "\n")
    }
    
    func removeComments() {
        
        lines = lines.compactMap { line in
            guard line.contains("//") else {
                return line
            }
            
            let firstSlashIndex = line.firstIndex(of: "/")!
            return String(line[line.startIndex..<firstSlashIndex])
        }
        
    }
    
    func removeWhiteSpaces() {
        lines = lines.map { $0.trimmingCharacters(in: .whitespaces) }
    }
        
    func removeEmptyLine() {
        lines = lines.compactMap { line in
            if line.isEmpty {
                return nil
            } else {
                return line
            }
        }
        
    }
}
