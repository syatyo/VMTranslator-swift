//
//  Label.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/24.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Label {
    let name: String
    
    func execute() -> String {
        var builder = CommandBuilder()
        builder.add(LabelSymbolInstruction(label: name))
        return builder.build()
    }
    
}

extension Label: AssemblyCommandGeneratable {
    
    func generate() -> String {
        return execute()
    }
    
}
