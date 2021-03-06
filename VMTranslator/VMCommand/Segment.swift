//
//  Segment.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/13.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

protocol Segment {
    func pushCommands(index: Int) -> [AssemblyCommand]
    func popCommands(index: Int) -> [AssemblyCommand]
}

protocol RegisterDefined {
    var `type`: A.DefinedSymbol { get }
}

extension Segment where Self: RegisterDefined {
    
    func pushCommands(index: Int) -> [AssemblyCommand] {
        let commands: [AssemblyCommand] = [
            A.symbol(type),
            C.assign(destination: .d, computation: .m),
            A.constant(index),
            C.assign(destination: .a, computation: .dPlusA),
            C.assign(destination: .d, computation: .m)
        ]
        return commands
    }
    
    func popCommands(index: Int) -> [AssemblyCommand] {
        var commands: [AssemblyCommand] = [
            A.symbol(type),
            C.assign(destination: .a, computation: .m)
        ]
        (0..<index).forEach { _ in
            commands.append(C.assign(destination: .a, computation: .aPlusOne))
        }

        return commands
    }
    
}

/// 関数のローカル変数を格納するセグメント
///
/// 関数に入るとVM実装によって動的に割り当てられ、0に初期化される
struct Local: Segment, RegisterDefined {
    var type: A.DefinedSymbol { return .lcl }
}


/// 関数の引数を格納するセグメント
///
/// 関数に入るとVM実装によって動的に割り当てられる。
struct Argument: Segment, RegisterDefined {
    var type: A.DefinedSymbol { return .arg }
}

/// 汎用セグメント。異なるヒープ領域に対応するように作られているセグメント。プログラミングの様々なニーズで用いられる
///
/// ヒープ上の選択された領域を操作するために、どのような関数でもこれらのセグメントを使うことができる
struct This: Segment, RegisterDefined {
    var type: A.DefinedSymbol { return .this }
}

/// 汎用セグメント。異なるヒープ領域に対応するように作られているセグメント。プログラミングの様々なニーズで用いられる
///
/// ヒープ上の選択された領域を操作するために、どのような関数でもこれらのセグメントを使うことができる
struct That: Segment, RegisterDefined {
    var type: A.DefinedSymbol { return .that }
}

/// thisとthatセグメントのベースアドレスを持つ2つの要素からなるセグメント
///
/// VMの関数で、pointerの0番目(または1番目)をあるアドレスに設定することができる。
struct Pointer: Segment {
    
    private func register(from index: Int) -> A.DefinedSymbol {
        switch index {
        case 0:
            return .this
        case 1:
            return .that
        default:
            fatalError()
        }
    }
    
    func pushCommands(index: Int) -> [AssemblyCommand] {
        return [
            A.symbol(register(from: index)),
            C.assign(destination: .d, computation: .m)
        ]
    }
   
    func popCommands(index: Int) -> [AssemblyCommand] {
        return [A.symbol(register(from: index))]
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
    
    func pushCommands(index: Int) -> [AssemblyCommand] {
        return [
            A.label(label(from: index)),
            C.assign(destination: .d, computation: .m)
        ]
    }
    
    func popCommands(index: Int) -> [AssemblyCommand] {
        return [A.label(label(from: index))]
    }
        
}

/// 0から32767(15bit)までの範囲のすべての定数値を持つ擬似セグメント
///
/// VM実装によってエミュレートされる。プログラムのすべての関数から見える。
struct Constant: Segment {
    
    func pushCommands(index: Int) -> [AssemblyCommand] {
        return [
            A.constant(index),
            C.assign(destination: .d, computation: .a)
        ]
    }
    
    func popCommands(index: Int) -> [AssemblyCommand] {
        fatalError("Constant segment cannot execute pop.")
    }
    
}

/// スタティック関数を格納する。スタティック変数は、同じ.vmファイルのすべての関数で共有する
///
/// 各.vmファイルに対して、VM実装により動的に割り当てられる。.vmファイルのすべての関数で共有される。
struct Static: Segment {
    let fileName: String
    
    /// include extension
    init(fileName: String) {
        self.fileName = fileName
            .components(separatedBy: ".")
            .first!
    }
    
    func pushCommands(index: Int) -> [AssemblyCommand] {
        return [
            A.label("\(fileName).\(index)"),
            C.assign(destination: .d, computation: .m)
        ]
    }
    
    func popCommands(index: Int) -> [AssemblyCommand] {
        return [A.label( "\(fileName).\(index)")]
    }
    
}
