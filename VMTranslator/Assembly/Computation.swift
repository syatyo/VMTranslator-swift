//
//  Computation.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/27.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

enum Computation {
    case zero
    case one
    case minusOne
    case d
    case a
    case m
    case notD
    case notA
    case notM
    case minusD
    case minusA
    case minusM
    case dPlusOne
    case aPlusOne
    case mPlusOne
    case dMinusOne
    case aMinusOne
    case mMinusOne
    case dPlusA
    case dPlusM
    case dMinusA
    case dMinusM
    case aMinusD
    case mMinusD
    case dAndA
    case dAndM
    case dOrA
    case dOrM
    
    init(boolean: Boolean) {
        switch boolean {
        case .true:
            self = .minusOne
        case .false:
            self = .zero
        }
    }
    
    var value: String {
        switch self {
        case .zero:
            return "0"
        case .one:
            return "1"
        case .minusOne:
            return "-1"
        case .d:
            return "D"
        case .a:
            return "A"
        case .m:
            return "M"
        case .notD:
            return "!D"
        case .notA:
            return "!A"
        case .notM:
            return "!M"
        case .minusD:
            return "-D"
        case .minusA:
            return "-A"
        case .minusM:
            return "-M"
        case .dPlusOne:
            return "D+1"
        case .aPlusOne:
            return "A+1"
        case .mPlusOne:
            return "M+1"
        case .dMinusOne:
            return "D-1"
        case .aMinusOne:
            return "A-1"
        case .mMinusOne:
            return "M-1"
        case .dPlusA:
            return "D+A"
        case .dPlusM:
            return "D+M"
        case .dMinusA:
            return "D-A"
        case .dMinusM:
            return "D-M"
        case .aMinusD:
            return "A-D"
        case .mMinusD:
            return "M-D"
        case .dAndA:
            return "D&A"
        case .dAndM:
            return "D&M"
        case .dOrA:
            return "D|A"
        case .dOrM:
            return "D|M"
        }
    }
    
}
