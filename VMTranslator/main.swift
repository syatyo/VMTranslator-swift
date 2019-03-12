//
//  main.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/23.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

if CommandLine.arguments.count == 2 {
    let givenPath = CommandLine.arguments[1]
    do {
        let translator = try VMTranslator(path: givenPath)
        try translator.startTranslating()
    } catch {
        print("error occured: \(error)")
    }
} else {
    print("Please input VMTranslator (filepath).")
    exit(EXIT_FAILURE)
}


