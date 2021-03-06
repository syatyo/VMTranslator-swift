//
//  Not.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/27.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Not: Command {
    
    var body: String {
        NewAssemblyCommand {
            A.symbol(.sp)
            C.assign(destination: .a, computation: .mMinusOne)
            C.assign(destination: .m, computation: .notM)
        }.body
    }
    
}
