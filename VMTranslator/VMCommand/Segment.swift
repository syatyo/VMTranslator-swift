//
//  Segment.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/13.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

protocol Segment {
    func pushCommands(index: Int) -> [AssemblyCommandGeneratable]
    func popCommands(index: Int) -> [AssemblyCommandGeneratable]
}

protocol RegisterDefined {
    var `type`: ATCommand.DefinedSymbol { get }
}

extension Segment where Self: RegisterDefined {
    
    func pushCommands(index: Int) -> [AssemblyCommandGeneratable] {
        let commands: [AssemblyCommandGeneratable] = [
            ATCommand(difinedSymbol: type),
            AssignCommand(destination: .d, computation: .m),
            ATCommand(constant: index),
            AssignCommand(destination: .a, computation: .dPlusA),
            AssignCommand(destination: .d, computation: .m)
        ]
        return commands
    }
    
    func popCommands(index: Int) -> [AssemblyCommandGeneratable] {
        var commands: [AssemblyCommandGeneratable] = [
            ATCommand(difinedSymbol: type),
            AssignCommand(destination: .a, computation: .m)
        ]
        (0..<index).forEach { _ in
            commands.append(AssignCommand(destination: .a, computation: .aPlusOne))
        }

        return commands
    }
    
}

/// 関数のローカル変数を格納するセグメント
///
/// 関数に入るとVM実装によって動的に割り当てられ、0に初期化される
struct Local: Segment, RegisterDefined {
    var type: ATCommand.DefinedSymbol { return .lcl }
}


/// 関数の引数を格納するセグメント
///
/// 関数に入るとVM実装によって動的に割り当てられる。
struct Argument: Segment, RegisterDefined {
    var type: ATCommand.DefinedSymbol { return .arg }
}

/// 汎用セグメント。異なるヒープ領域に対応するように作られているセグメント。プログラミングの様々なニーズで用いられる
///
/// ヒープ上の選択された領域を操作するために、どのような関数でもこれらのセグメントを使うことができる
struct This: Segment, RegisterDefined {
    var type: ATCommand.DefinedSymbol { return .this }
}

/// 汎用セグメント。異なるヒープ領域に対応するように作られているセグメント。プログラミングの様々なニーズで用いられる
///
/// ヒープ上の選択された領域を操作するために、どのような関数でもこれらのセグメントを使うことができる
struct That: Segment, RegisterDefined {
    var type: ATCommand.DefinedSymbol { return .that }
}

/// thisとthatセグメントのベースアドレスを持つ2つの要素からなるセグメント
///
/// VMの関数で、pointerの0番目(または1番目)をあるアドレスに設定することができる。
struct Pointer: Segment {
    
    private func register(from index: Int) -> ATCommand.DefinedSymbol {
        switch index {
        case 0:
            return .this
        case 1:
            return .that
        default:
            fatalError()
        }
    }
    
    func pushCommands(index: Int) -> [AssemblyCommandGeneratable] {
        return [
            ATCommand(difinedSymbol: register(from: index)),
            AssignCommand(destination: .d, computation: .m)
        ]
    }
   
    func popCommands(index: Int) -> [AssemblyCommandGeneratable] {
        return [ATCommand(difinedSymbol: register(from: index))]
    }
    
}

/// 固定された8つの要素からなるセグメント。一時的な変数を格納するために用いられる。
///
/// 目的に応じてVM関数によって使われる。プログラムのすべての関数で共有される。
struct Temp: Segment {
    private let registerStartingIndex: Int = 5
    
    private func label(from index: Int) -> String {
        return "R\(registerStartingIndex + index)"
    }
    
    func pushCommands(index: Int) -> [AssemblyCommandGeneratable] {
        return [
            ATCommand(label: label(from: index)),
            AssignCommand(destination: .d, computation: .m)
        ]
    }
    
    func popCommands(index: Int) -> [AssemblyCommandGeneratable] {
        return [ATCommand(label: label(from: index))]
    }
        
}
