//
//  UserSearchView.swift
//  UserSearchView
//
//  Created by Hyakusetufutou on 2025/08/27
//  
//

import SwiftUI

struct UserSearchView: View {
    @State private var searchText: String = ""
    private let actionCreator: ActionCreator
    @StateObject var userSearchStore: UserSearchStore
    
    init(actionCreator: ActionCreator = ActionCreator(),
         userSearchStore: UserSearchStore = .shared) {
        self.actionCreator = actionCreator
        _userSearchStore = StateObject(wrappedValue: userSearchStore)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("user name", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.asciiCapable)
                    .padding()
                    .task(id: searchText) {
                        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
                        
                        guard !query.isEmpty else { return }
                        
                        do {
                            try await Task.sleep(nanoseconds: 400_000_000)
                        } catch {
                            return
                        }
                        
                        guard !Task.isCancelled else { return }
                        
                        actionCreator.searchUser(query: query)
                    }
                Spacer()
                List(userSearchStore.users) { user in
                    NavigationLink(destination: RepositoryView(repositoryUrlString: user.reposUrl).onAppear {
                        actionCreator.startRepositoriesLoading()
                    }) {
                        UserRow(user: user)
                    }
                }
                .refreshable {
                    actionCreator.searchUser(query: searchText)
                }
            }
            .navigationTitle("Search Github User")
        }
    }
}

#Preview {
    UserSearchView()
}
