//
//  main.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/23.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

// 1. SimpleAdd.vm to SimpleAdd.asm
do {
    let vmTranslator = try VMTranslator(path: simpleAddTestPath)
    try vmTranslator.startTranslating()
} catch {
    print("Error occured: \(error)")
    exit(EXIT_FAILURE)
}

print("Success to translate SimpleAdd.asm")

// 2. StackTest.vm to StackTest.asm
do {
    let vmTranslator = try VMTranslator(path: stackTestPath)
    try vmTranslator.startTranslating()
} catch {
    print("Error occured: \(error)")
    exit(EXIT_FAILURE)
}

print("Success to translate StackTestPath.asm")

// 3. BasicTest.vm to BasicTest.asm
do {
    let vmTranslator = try VMTranslator(path: basicTestPath)
    try vmTranslator.startTranslating()
} catch {
    print("Error occured: \(error)")
    exit(EXIT_FAILURE)
}

print("Success to translate BasicTest.asm")

// 4. PointerTest.vm to PointerTest.asm
do {
    let vmTranslator = try VMTranslator(path: pointerTestPath)
    try vmTranslator.startTranslating()
} catch {
    print("Error occured: \(error)")
    exit(EXIT_FAILURE)
}

print("Success to translate PointerTest.asm")

// 5. StaticTest.vm to PointerTest.asm
do {
    let vmTranslator = try VMTranslator(path: staticTestPath)
    try vmTranslator.startTranslating()
} catch {
    print("Error occured: \(error)")
    exit(EXIT_FAILURE)
}

print("Success to translate StaticTest.asm")

// 6. BasicLoop.vm to PointerTest.asm
do {
    let vmTranslator = try VMTranslator(path: basicLoopPath)
    try vmTranslator.startTranslating()
} catch {
    print("Error occured: \(error)")
    exit(EXIT_FAILURE)
}

print("Success to translate BasicLoop.asm")

