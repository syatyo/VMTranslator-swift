//
//  Equal.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/25.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Equal: Conditionable {
    var type: ConditionType { return .jeq }
    
    private(set) var symbolCounter: Int = 0
    mutating func incrementSymbolCounter() {
        symbolCounter += 1
    }
    
}
