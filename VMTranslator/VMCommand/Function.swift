//
//  Function.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/30.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Function {
    let name: String
    let numberOfLocalVariables: Int
    
    /// Initializer of function command.
    ///
    /// - Parameters:
    ///   - name: name of function. It should not start from number.
    ///   - numberOfLocalVariables: number of local variable used in the function. It is greater than equal zero.
    init?(name: String, numberOfLocalVariables: Int) {
        guard !name.isEmpty else {
            return nil
        }
        
        let firstCharacter = String(name.first!)
        guard Int(firstCharacter) == nil else {
            return nil
        }
        
        guard numberOfLocalVariables >= 0 else {
            return nil
        }
        
        self.name = name
        self.numberOfLocalVariables = numberOfLocalVariables
    }
    
}
