//
//  RepositoryStore.swift
//  GitHubSearcher
//  
//  Created by Hyakusetufutou on 2025/08/29
//  
//

import Foundation

class RepositoryStore: Store {
    static let shared = RepositoryStore(dispatcher: .shared)
    @Published var isLoading = true
    @Published var repositories = [Repository]()
    
    override func onDispatch(_ action: Action) {
        switch action {
        case .searchUser(_):
            return
        case .startRepositoriesLoaing:
            isLoading = true
        case .getRepositories(let repositories):
            self.repositories = repositories
            isLoading = false
        }
    }
}
