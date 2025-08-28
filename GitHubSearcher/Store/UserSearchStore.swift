//
//  UserSearchStore.swift
//  GitHubSearcher
//  
//  Created by Hyakusetufutou on 2025/08/29
//  
//

import Foundation

class UserSearchStore: Store {
    static let shared = UserSearchStore(dispatcher: .shared)
    @Published var users = [User]()
    
    override func onDispatch(_ action: Action) {
        switch action {
        case .searchUser(let users):
            self.users = users
        case .startRepositoriesLoaing, .getRepositories(_):
            return
        }
    }
}
