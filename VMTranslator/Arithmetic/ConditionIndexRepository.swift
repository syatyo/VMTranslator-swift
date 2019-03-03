//
//  ConditionIndexCounter.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/03.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

protocol ConditionIndexRepository {
    func getCurrentValue(for type: String) -> Int
    func incrementIndex(for type: String)
}

extension ConditionIndexStore: ConditionIndexRepository {
    
    func getCurrentValue(for type: String) -> Int {
        return value(for: type) ?? 0
    }
    
    func incrementIndex(for type: String) {
        var currentValue = getCurrentValue(for: type)
        currentValue += 1
        setValue(currentValue, for: type)
    }
    
}
