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
}

extension Label: VMCommand {
    
    var assemblyTranslatedCommands: [AssemblyCommandGeneratable] {
        return [LabelSymbolInstruction(label: name)]
    }
    
}
