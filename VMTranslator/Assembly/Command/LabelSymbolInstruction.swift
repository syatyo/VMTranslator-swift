//
//  LabelCommand.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/03.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

/// (Label) command in assembly.
struct LabelSymbol {
    
    private var value: String
    
    init(label: String) {
        self.value = label
    }
    
}

extension LabelSymbol: AssemblyCommand {
    
    func generate() -> String {
        return "(\(value))"
    }
        
}
