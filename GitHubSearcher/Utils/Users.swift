//
//  Users.swift
//  GitHubSearcher
//  
//  Created by Hyakusetufutou on 2025/08/28
//  
//

import Foundation


struct User: Codable, Identifiable {
    let id = UUID()
    let login: String
    let avatarUrl: String
    let reposUrl: String
    static let mockUser = User(login: "Hyakusetufutou", avatarUrl: "https://avatars.githubusercontent.com/u/99530717?v=4", reposUrl: "https://api.github.com/users/Hyakusetufutou/repos")
    
    private enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case reposUrl = "repos_url"
    }
}

struct Users: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [User]
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

