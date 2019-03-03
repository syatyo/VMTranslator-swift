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
    var repository: ConditionIndexRepository { return ConditionIndexStore.shared }
    
}
