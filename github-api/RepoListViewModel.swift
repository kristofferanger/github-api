//
//  RepoListViewModel.swift
//  github-api
//
//  Created by Kristoffer Anger on 2023-02-21.
//

import Foundation

enum LoadingState {
    case unknown
    case isLoading
    case finished
    case error(Error)
}

class RepoListViewModel {
    
    var repos = [Repo]()
        
    var loading: (() -> Void) = {}
    var showError: ((Error) -> Void) = { _ in }
    var showData: (() -> Void) = {}
    
    var state: LoadingState = .unknown {
        didSet {
            switch state {
            case .isLoading:
                self.loadRepos()
            case .error(let error):
                self.showError(error)
            case .finished:
                self.showData()
            case .unknown:
                break
            }
        }
    }
    
    private func loadRepos() {
        self.loading()
        NetworkManager.getRepos { [weak self] result in
            switch result {
            case .success(let repos):
                self?.repos = repos
                self?.state = .finished
            case .failure(let error):
                self?.state = .error(error)
            }
        }
    }
}
