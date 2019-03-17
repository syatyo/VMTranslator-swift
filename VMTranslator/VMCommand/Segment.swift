//
//  Segment.swift
//  VMTranslator
//
//  Created by 山田良治 on 2019/03/13.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

protocol Segment {
    var index: Int { get }
    func execute() -> String
}

protocol RegisterDefined {
    var `type`: ATCommand.DefinedSymbol { get }
}

extension Segment where Self: RegisterDefined {
    
    func execute() -> String {
        var builder = CommandBuilder()
        builder.add(ATCommand(difinedSymbol: type))
        builder.add(AssignCommand(destination: .d, computation: .m))
        builder.add(ATCommand(constant: index))
        builder.add(AssignCommand(destination: .a, computation: .dPlusA))
        builder.add(AssignCommand(destination: .d, computation: .m))
        return builder.build()
    }
    
}

extension Segment where Self: AssemblyCommandGeneratable {
    
    func generate() -> String {
        return execute()
    }

}

/// 関数のローカル変数を格納するセグメント
///
/// 関数に入るとVM実装によって動的に割り当てられ、0に初期化される
struct Local: Segment, RegisterDefined, AssemblyCommandGeneratable {
    var type: ATCommand.DefinedSymbol { return .lcl }
    let index: Int
}


/// 関数の引数を格納するセグメント
///
/// 関数に入るとVM実装によって動的に割り当てられる。
struct Argument: Segment, RegisterDefined, AssemblyCommandGeneratable {
    var type: ATCommand.DefinedSymbol { return .arg }
    let index: Int
}

/// 汎用セグメント。異なるヒープ領域に対応するように作られているセグメント。プログラミングの様々なニーズで用いられる
///
/// ヒープ上の選択された領域を操作するために、どのような関数でもこれらのセグメントを使うことができる
struct This: Segment, RegisterDefined, AssemblyCommandGeneratable {
    var type: ATCommand.DefinedSymbol { return .this }
    let index: Int
}

/// 汎用セグメント。異なるヒープ領域に対応するように作られているセグメント。プログラミングの様々なニーズで用いられる
///
/// ヒープ上の選択された領域を操作するために、どのような関数でもこれらのセグメントを使うことができる
struct That: Segment, RegisterDefined, AssemblyCommandGeneratable {
    var type: ATCommand.DefinedSymbol { return .that }
    let index: Int
}

/// thisとthatセグメントのベースアドレスを持つ2つの要素からなるセグメント
///
/// VMの関数で、pointerの0番目(または1番目)をあるアドレスに設定することができる。
struct Pointer: Segment, AssemblyCommandGeneratable {
    let index: Int
    private let register: ATCommand.DefinedSymbol
    
    init(index: Int) {
        self.index = index
        
        switch index {
        case 0:
            self.register = .this
        case 1:
            self.register = .that
        default:
            fatalError()
        }
    }
    
    func execute() -> String {
        var builder = CommandBuilder()
        builder.add(ATCommand(difinedSymbol: register))
        builder.add(AssignCommand(destination: .d, computation: .m))
        return builder.build()
    }

    func generate() -> String {
        return execute()
    }
    
}

/// 固定された8つの要素からなるセグメント。一時的な変数を格納するために用いられる。
///
/// 目的に応じてVM関数によって使われる。プログラムのすべての関数で共有される。
struct Temp: Segment, AssemblyCommandGeneratable {
    var index: Int
    private let label: String
    private let registerStartingIndex: Int = 5
    
    init(index: Int) {
        self.index = index
        self.label = "R\(registerStartingIndex + index)"
    }
    
    func execute() -> String {
        var builder = CommandBuilder()
        builder.add(ATCommand(label: label))
        builder.add(AssignCommand(destination: .d, computation: .m))
        return builder.build()
    }
    
    func generate() -> String {
        return execute()
    }
    
}
