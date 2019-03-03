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
    var repository: ConditionIndexRepository { return ConditionIndexStore.shared }
    
}
