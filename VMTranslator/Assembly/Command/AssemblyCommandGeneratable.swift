//
//  AssemblerCommand.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/03.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

protocol AssemblyCommandGeneratable {
    func generate() -> String
}
