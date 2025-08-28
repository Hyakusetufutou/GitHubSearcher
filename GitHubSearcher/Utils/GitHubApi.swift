//
//  GitHubApi.swift
//  GitHubSearcher
//  
//  Created by Hyakusetufutou on 2025/08/28
//  
//

import Foundation

protocol ApiRequestable {
    func fetchUser(query: String, completion: @escaping (Result<[User], ModelError>) -> Void)
    func fetchRepository(urlString: String, completion: @escaping (Result<[Repository], ModelError>) -> Void)
}

struct GitHubApi: ApiRequestable {
    private var endpoint: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        return components
    }
    
    func fetchUser(query: String, completion: @escaping (Result<[User], ModelError>) -> Void) {
        guard !query.isEmpty,
              let url = userSearchEndpoint(query: query) else {
            completion(.failure(.urlError))
            return
        }
        
        Task {
            let result = await fetch(url: url)
            
            switch result {
            case .success(let data):
                guard let users = try? JSONDecoder().decode(Users.self, from: data) else {
                    completion(.failure(.jsonParseError(String(data: data, encoding: .utf8) ?? "")))
                    return
                }
                completion(.success(users.items))
            case .failure(let error):
                completion(.failure(.responseError(error)))
            }
        }
            
    }
    
    func fetchRepository(urlString: String, completion: @escaping (Result<[Repository], ModelError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.urlError))
            return
        }
        
        Task {
            let result = await fetch(url: url)
            
            switch result {
            case .success(let data):
                guard let repositories = try? JSONDecoder().decode([Repository].self, from: data) else {
                    completion(.failure(.jsonParseError(String(data: data, encoding: .utf8) ?? "")))
                    return
                }
                completion(.success(repositories))
            case .failure(let error):
                completion(.failure(.responseError(error)))
            }
        }
    }
    
    private func userSearchEndpoint(query: String) -> URL? {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            return nil
        }
        
        var urlComponents = endpoint
        urlComponents.path = "/search/users"
        urlComponents.queryItems = [URLQueryItem(name: "q", value: encodedQuery)]
        guard let url = urlComponents.url else {
            return nil
        }
        return url
    }
    
    @MainActor
    private func fetch(url: URL) async -> Result<Data, Error> {
        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
            return .success(data)
        } catch {
            return .failure(error)
        }
}
}
