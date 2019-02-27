//
//  Less.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/27.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Less: ConditionCommand {
    var type: ConditionType {
        return .jlt
    }
    
    private(set) var symbolCounter: Int = 0
    
    mutating func incrementSymbolCounter() {
        symbolCounter += 1
    }
    
    
}
