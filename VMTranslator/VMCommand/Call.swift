//
//  Call.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/30.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Call {
    let name: String
    let numberOfArguments: Int
    
    var assemblyTranslatedCommands: [AssemblyCommand] = []
    
    /// Initializer of Call command.
    ///
    /// - Parameters:
    ///   - name: name of function. It should not start from number.
    ///   - numberOfArguments: number of arguments used in the function. It is greater than equal zero.
    init?(name: String, numberOfArguments: Int) {
        guard !name.isEmpty else {
            return nil
        }
        
        let firstCharacter = String(name.first!)
        guard Int(firstCharacter) == nil else {
            return nil
        }
        
        guard numberOfArguments >= 0 else {
            return nil
        }
        
        self.name = name
        self.numberOfArguments = numberOfArguments
    }
    
    // MARK: - House keeping functions
    mutating func pushLocalVariable() {
        
        (0..<numberOfArguments).forEach { _ in
            assemblyTranslatedCommands.append(AInstruction(difinedSymbol: .sp))
            assemblyTranslatedCommands.append(CInstruction.assign(destination: .am, computation: .mPlusOne))
            assemblyTranslatedCommands.append(CInstruction.assign(destination: .a, computation: .aMinusOne))
            assemblyTranslatedCommands.append(CInstruction.assign(destination: .m, computation: .zero))
        }
    }
    
}

extension Call: VMCommand { }
