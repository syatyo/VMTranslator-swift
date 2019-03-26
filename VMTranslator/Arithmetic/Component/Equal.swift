//
//  Equal.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/25.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Equal: Conditionable {
    var conditionType: ConditionType { return .jeq }
    private(set) var repository: ConditionIndexRepository!
    mutating func inject(repository: ConditionIndexRepository) {
        self.repository = repository
    }

}

extension Equal: VMCommand {
    
    var assemblyTranslatedCommands: [AssemblyCommandGeneratable] {
        return translateToAssemblyCommands()
    }
    
}
