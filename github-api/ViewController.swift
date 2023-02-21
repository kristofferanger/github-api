//
//  ViewController.swift
//  github-api
//
//  Created by Kristoffer Anger on 2023-02-21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NetworkManager.getRepos { result in
            switch result {
            case .success(let repos):
                repos.forEach { repo in
                    print(repo.name)
                }
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }


}

