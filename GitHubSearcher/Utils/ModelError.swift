//
//  ModelError.swift
//  GitHubSearcher
//  
//  Created by Hyakusetufutou on 2025/08/28
//  
//

import Foundation

enum ModelError: Error {
    case urlError
    case responseError(Error)
    case responseDataEmpty
    case jsonParseError(String)
    
    var localizedDescription: String {
        switch self {
        case .urlError: return "URL変換に失敗しました"
        case .responseError(let error): return "API実行に失敗しました。詳細: \(error)"
        case .responseDataEmpty: return "API取得データが空でした。"
        case .jsonParseError(let message): return "JSONのパースに失敗しました。データ: \(message)"
            
        }
    }
}
