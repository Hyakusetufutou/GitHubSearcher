//
//  ActionCreator.swift
//  GitHubSearcher
//  
//  Created by Hyakusetufutou on 2025/08/28
//  
//

import Foundation

final class ActionCreator {
    private let dispatcher: Dispatcher
    private let githubApi: ApiRequestable
    
    init(dispatcher: Dispatcher = .shared, githubApi: ApiRequestable = GitHubApi()) {
        self.dispatcher = dispatcher
        self.githubApi = githubApi
    }
}

extension ActionCreator {
    func searchUser(query: String) {
        githubApi.fetchUser(query: query) { [weak self] result in
            switch result {
            case .success(let users):
                self?.dispatcher.dispatch(.searchUser(users))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ActionCreator {
    func startRepositoriesLoading() {
        dispatcher.dispatch(.startRepositoriesLoaing)
    }
    
    func getRepositories(urlString: String) {
        githubApi.fetchRepository(urlString: urlString) { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.dispatcher.dispatch(.getRepositories(repositories))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
