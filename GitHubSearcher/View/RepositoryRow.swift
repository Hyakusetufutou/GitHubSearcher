//
//  RepositoryRow.swift
//  GitHubSearcher
//  
//  Created by Hyakusetufutou on 2025/08/29
//  
//

import SwiftUI

struct RepositoryRow: View {
    let repository: Repository
    
    var body: some View {
        VStack {
            HStack {
                Text(repository.name)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .padding()
            HStack {
                Text(repository.description ?? "")
                    .font(.caption)
                Spacer()
            }
            HStack {
                Text(repository.language ?? "")
                Spacer()
                Image(systemName: "star.fill")
                Text(String(repository.stargazersCount))
                Spacer()
                Text("falk: \(String(repository.forksCount))")
                Spacer()
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    RepositoryRow(repository: Repository.mock)
}
