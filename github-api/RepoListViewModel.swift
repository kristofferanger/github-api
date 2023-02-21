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
    case finished([Repo])
    case error(Error)
}

class RepoListViewModel {
    
    let repoOwner: String = NetworkManager.owner
    
    var loading: (() -> Void) = {}
    var showError: ((Error) -> Void) = { _ in }
    var showData: (([Repo]) -> Void) = { _ in }
    
    var state: LoadingState = .unknown {
        didSet {
            switch state {
            case .isLoading:
                self.loadRepos()
            case .error(let error):
                self.showError(error)
            case .finished(let repos):
                self.showData(repos)
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
                self?.state = .finished(repos)
            case .failure(let error):
                self?.state = .error(error)
            }
        }
    }
}
