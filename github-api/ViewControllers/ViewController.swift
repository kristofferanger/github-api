//
//  ViewController.swift
//  github-api
//
//  Created by Kristoffer Anger on 2023-02-21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var viewModel: RepoListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.backgroundColor

        // init view model and start loading data
        viewModel = RepoListViewModel()
        viewModel.loading = loading
        viewModel.showError = showError
        viewModel.showData = showData
        viewModel.state = .isLoading
        
        // set navbar title
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "My repositories"
        
        // setup tableView
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - RepoListViewModel methods
    func loading() {
        // show spinner
        spinner.isHidden = false
    }
    
    func showError(_ error: Error) {
        // show error view
        spinner.isHidden = true
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)

        let action = UIAlertAction(title: "Try again", style: .default) { [weak self] _ in
            self?.viewModel.state = .isLoading
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func showData() {
        // show repos
        spinner.isHidden = true
        tableView.reloadData()
    }
    
    func reloadData() {
        viewModel.state = .isLoading
    }
    
    //  MARK: - UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoTableViewCell.identifier, for: indexPath) as! RepoTableViewCell
        
        let repo = viewModel.repos[indexPath.row]
        cell.configure(with: repo)
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = viewModel.repos[indexPath.row]
        
        let detailView = DetailViewController()
        detailView.repo = repo
        
        self.navigationController?.pushViewController(detailView, animated: true)
    }

}
