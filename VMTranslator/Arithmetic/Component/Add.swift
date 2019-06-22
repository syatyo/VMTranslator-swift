//
//  Add.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/24.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Add: Command {
    
    var body: String {
        NewAssemblyCommand {
            A.symbol(.sp)
            C.assign(destination: .am, computation: .mMinusOne)
            C.assign(destination: .d, computation: .m)
            C.assign(destination: .a, computation: .aMinusOne)
            C.assign(destination: .m, computation: .dPlusM)
        }.body
    }
    
}
