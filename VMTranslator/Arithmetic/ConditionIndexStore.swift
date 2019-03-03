//
//  ConditionIndexStore.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/03.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

final class ConditionIndexStore {
    private var store: [String: Int] = [:]
    static let shared = ConditionIndexStore()
    private init() { }
    
    func value(for type: String) -> Int? {
        return store[type]
    }
    
    func setValue(_ value: Int, for type: String) {
        store[type] = value
    }
    
}
