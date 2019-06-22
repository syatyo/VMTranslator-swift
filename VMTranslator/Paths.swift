//
//  Paths.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/06/22.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

let outputDirPath = absolutePath(from: "TestOutputFiles/")

let inputDirPath = absolutePath(from: "TestInputFiles/")

func absolutePath(from path: String) -> String {
    FileManager.default.homeDirectoryForCurrentUser.path + "/Documents/GitHub/VMTranslator-swift/" + path
}
