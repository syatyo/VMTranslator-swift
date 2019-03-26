//
//  VMCommand.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/26.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

protocol VMCommand {
    var assemblyTranslatedCommands: [AssemblyCommandGeneratable] { get }
}
