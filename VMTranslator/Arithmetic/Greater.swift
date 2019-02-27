//
//  Greater.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/27.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Greater: ConditionCommand {
    var type: ConditionType { return .jgt }
    
    private(set) var symbolCounter = 0
    mutating func incrementSymbolCounter() {
        symbolCounter += 1
    }
    
}
