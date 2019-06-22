//
//  ConditionIndexCounter.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/03.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

protocol ConditionIndexRepository {
    func incrementIndex(for type: String) -> Int
}

extension ConditionIndexStore: ConditionIndexRepository {
    
    func incrementIndex(for type: String) -> Int {
        let currentValue = value(for: type) ?? 0
        let incrementedValue = currentValue + 1
        setValue(incrementedValue, for: type)
        return incrementedValue
    }
    
}
