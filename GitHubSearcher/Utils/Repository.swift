//
//  Repository.swift
//  GitHubSearcher
//  
//  Created by Hyakusetufutou on 2025/08/28
//  
//

import Foundation

struct Repository: Codable, Identifiable {
    let id = UUID()
    let name: String
    let htmlUrl: String
    let description: String?
    let language: String?
    let stargazersCount: Int
    let forksCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case name
        case htmlUrl = "html_url"
        case description
        case language
        case stargazersCount = "stargazers_count"
        case forksCount = "forks_count"
    }
    
    static let mock = Repository(name: "GitHubSearcher", htmlUrl: "https://github.com/Hyakusetufutou?tab=repositories", description: "GitHub Searcher", language: "Swift", stargazersCount: 1000, forksCount: 100)
}
