//
//  DetailViewController.swift
//  github-api
//
//  Created by Kristoffer Anger on 2023-02-22.
//

import UIKit

class DetailViewController: UIViewController {
    
    var repo: Repo?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.backgroundColor
        self.title = repo?.name ?? "Unknown"
        
        guard let repo else { return }
        
        let dateLabel = UILabel()
        dateLabel.font = .italicSystemFont(ofSize: 14)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateLabel.text = dateFormatter.string(from: repo.createdAt)
        
        let detailLabel = UILabel()
        detailLabel.font = .systemFont(ofSize: 14)
        detailLabel.text = repo.description
        detailLabel.numberOfLines = 0
        
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseBackgroundColor = UIColor(hex: kTealColor)
        configuration.baseForegroundColor = UIColor.white
        configuration.buttonSize = .small
        configuration.title = "Go to GitHub >"
        
        let action = UIAction {  _ in
            guard let url = URL(string: repo.htmlUrl) else { return }
            UIApplication.shared.open(url)
        }
        let button = UIButton(configuration: configuration, primaryAction: action)

        let stackView = UIStackView(arrangedSubviews: [dateLabel, detailLabel, button])
        stackView.axis = .vertical
        stackView.spacing = 10
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .systemBackground
        backgroundView.elevate(height: 4)
        backgroundView.layer.cornerRadius = 10.0
        backgroundView.addSubviewPinnedToEdges(stackView, top: 10, bottom: nil, leading: 10, trailing: 10)
        
        self.view.addSubviewPinnedToEdges(backgroundView, leading: 16, trailing: 16, useSafeArea: true)
    }
}
