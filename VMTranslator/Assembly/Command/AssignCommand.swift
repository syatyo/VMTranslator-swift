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

extension AssignCommand: AssemblyCommandGeneratable {
    func generateAssembly() -> String {
        return "\(destination.value)=\(computation.value)"
    }
    
}

extension AssignCommand: CustomStringConvertible {
    
    var description: String {
        return generateAssembly()
    }
    
}
