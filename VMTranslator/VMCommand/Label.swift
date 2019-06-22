//
//  Label.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/24.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Label: Command {
    let name: String
    
    var body: String {
        LabelSymbol(label: name).body
    }
    
}

extension Label: VMCommand {
    
    var assemblyTranslatedCommands: [AssemblyCommand] {
        return [LabelSymbol(label: name)]
    }
    
}
