//
//  RepositoryView.swift
//  GitHubSearcher
//  
//  Created by Hyakusetufutou on 2025/08/29
//  
//

import SwiftUI

struct RepositoryView: View {
    let repositoryUrlString: String
    private let actionCreator: ActionCreator
    @StateObject var repositoryStore: RepositoryStore
    
    init(repositoryUrlString: String,
         actionCreator: ActionCreator = ActionCreator(),
         repositoryStore: RepositoryStore = .shared) {
        self.repositoryUrlString = repositoryUrlString
        self.actionCreator = actionCreator
        _repositoryStore = StateObject(wrappedValue: repositoryStore)
    }
    
    var body: some View {
        if repositoryStore.isLoading {
            ProgressView()
                .scaleEffect(x: 3, y: 3, anchor: .center)
                .onAppear {
                    actionCreator.getRepositories(urlString: repositoryUrlString)
                }
        } else {
            if repositoryStore.repositories.isEmpty {
                Text("No Repository")
            } else {
                List(repositoryStore.repositories) { repository in
                    RepositoryRow(repository: repository)
                }
            }
        }
    }
}

#Preview {
    RepositoryView(repositoryUrlString: "https://api.github.com/users/Hyakusetufutou/repos")
}
