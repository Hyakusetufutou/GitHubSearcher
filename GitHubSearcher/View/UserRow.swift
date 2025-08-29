//
//  UserRow.swift
//  GitHubSearcher
//  
//  Created by Hyakusetufutou on 2025/08/29
//  
//

import SwiftUI

struct UserRow: View {
    let user: User
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: user.avatarUrl)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .clipShape(Circle())
            .frame(width: 50, height: 50)
            .padding()
            Spacer()
            Text(user.login)
                .padding()
            Spacer()
        }
    }
}

#Preview {
    UserRow(user: User.mockUser)
}
