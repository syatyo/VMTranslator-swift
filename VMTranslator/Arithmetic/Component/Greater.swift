//
//  Greater.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/27.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Greater: Conditionable {
    
    var conditionType: ConditionType { return .jgt }
    private(set) var repository: ConditionIndexRepository!
    mutating func inject(repository: ConditionIndexRepository) {
        self.repository = repository
    }

}

extension Greater: VMCommand {
    
    var assemblyTranslatedCommands: [AssemblyCommandGeneratable] {
        return translateToAssemblyCommands()
    }
    
}
