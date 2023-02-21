//
//  ViewController.swift
//  github-api
//
//  Created by Kristoffer Anger on 2023-02-21.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel: RepoListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // init view model and start loading data
        viewModel = RepoListViewModel()
        viewModel.loading = loading
        viewModel.showError = showError
        viewModel.showData = showData
        viewModel.state = .isLoading
        
        // set navbar title
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "My repositories"
    }
    
    func loading() {
        // show spinner
    }
    
    func showError(_ error: Error) {
        // show error view
    }
    
    func showData(_ data: [Repo]) {
        // show repos
    }


}

