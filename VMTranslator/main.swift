//
//  main.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/02/23.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

// 1. SimpleAdd.vm to SimpleAdd.asm
let simpleAddInputPath = inputDirPath + "SimpleAdd.vm"
do {
    let vmTranslator = try VMTranslator(inputPath: simpleAddInputPath)
    try vmTranslator.startTranslating()
} catch {
    print("Error occured: \(error)")
    exit(EXIT_FAILURE)
}

print("Success to translate SimpleAdd.asm")

// 2. StackTest.vm to StackTest.asm
let stackTestInputPath = inputDirPath + "StackTest.vm"
do {
    let vmTranslator = try VMTranslator(inputPath: stackTestInputPath)
    try vmTranslator.startTranslating()
} catch {
    print("Error occured: \(error)")
    exit(EXIT_FAILURE)
}

print("Success to translate StackTestPath.asm")

// 3. BasicTest.vm to BasicTest.asm
let basicTestInputPath = inputDirPath + "BasicTest.vm"
do {
    let vmTranslator = try VMTranslator(inputPath: basicTestInputPath)
    try vmTranslator.startTranslating()
} catch {
    print("Error occured: \(error)")
    exit(EXIT_FAILURE)
}

print("Success to translate BasicTest.asm")

// 4. PointerTest.vm to PointerTest.asm
let pointerTestInputPath = inputDirPath + "PointerTest.vm"
do {
    let vmTranslator = try VMTranslator(inputPath: pointerTestInputPath)
    try vmTranslator.startTranslating()
} catch {
    print("Error occured: \(error)")
    exit(EXIT_FAILURE)
}

print("Success to translate PointerTest.asm")

// 5. StaticTest.vm to PointerTest.asm
let staticTestInputPath = inputDirPath + "StaticTest.vm"
do {
    let vmTranslator = try VMTranslator(inputPath: staticTestInputPath)
    try vmTranslator.startTranslating()
} catch {
    print("Error occured: \(error)")
    exit(EXIT_FAILURE)
}

print("Success to translate StaticTest.asm")

// 6. BasicLoop.vm to PointerTest.asm
let basicLoopInputPath = inputDirPath + "BasicLoop.vm"
do {
    let vmTranslator = try VMTranslator(inputPath: basicLoopInputPath)
    try vmTranslator.startTranslating()
} catch {
    print("Error occured: \(error)")
    exit(EXIT_FAILURE)
}

print("Success to translate BasicLoop.asm")

// 7. FibonacciSeries.vm to PointerTest.asm
let fibonacciSeriesInputPath = inputDirPath + "FibonacciSeries.vm"
do {
    let vmTranslator = try VMTranslator(inputPath: fibonacciSeriesInputPath)
    try vmTranslator.startTranslating()
} catch {
    print("Error occured: \(error)")
    exit(EXIT_FAILURE)
}

print("Success to translate FibonacciSeries.asm")
