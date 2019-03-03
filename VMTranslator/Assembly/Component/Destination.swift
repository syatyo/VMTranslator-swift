//
//  Destination.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/27.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

enum Destination: String {
    case m
    case d
    case md
    case a
    case am
    case ad
    case amd
    
    var value: String {
        return rawValue.uppercased()
    }
    
}
