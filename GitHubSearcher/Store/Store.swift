//
//  Store.swift
//  GitHubSearcher
//  
//  Created by Hyakusetufutou on 2025/08/29
//  
//

import Foundation

class Store: ObservableObject {
    private lazy var dispatchToken: DispatchToken = {
        return dispatcher.register { [weak self] action in
            self?.onDispatch(action)
        }
    }()
    
    private let dispatcher: Dispatcher
    
    deinit {
        dispatcher.unregister(dispatchToken)
    }
    
    init(dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
        _ = dispatchToken
    }
    
    func onDispatch(_ action: Action) {
        fatalError("must override")
    }
}
