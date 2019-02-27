//
//  AssignCommand.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/27.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct AssignCommand {
    let destination: Destination
    let computation: Computation
}

extension AssignCommand {
    
    var value: String {
        return "\(destination.value)=\(computation.value)"
    }
}
