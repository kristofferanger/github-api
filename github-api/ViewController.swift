//
//  ViewController.swift
//  github-api
//
//  Created by Kristoffer Anger on 2023-02-21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var viewModel: RepoListViewModel!
    
    static let repoCellIdentifier = "RepoCell"

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
    
    // MARK: - RepoListViewModel methods
    func loading() {
        // show spinner
    }
    
    func showError(_ error: Error) {
        // show error view
    }
    
    func showData() {
        // show repos
    }

    
    //  MARK: - UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.repoCellIdentifier, for: indexPath)
        
        let repo = viewModel.repos[indexPath.row]
        
        cell.textLabel?.text = repo.name
        
        return cell
    }

}

