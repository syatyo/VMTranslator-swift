//
//  Jump.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/27.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

enum Jump: String {
    case jgt // x > 0
    case jeq // x == 0
    case jge // x >= 0
    case jlt // x < 0
    case jne // x != 0
    case jle // x <= 0
    
    var value: String {
        return rawValue.uppercased()
    }

}
