//
//  RepoTableViewCell.swift
//  github-api
//
//  Created by Kristoffer Anger on 2023-02-22.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    static let identifier = "RepoTableViewCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // add shadow and rounded corners
        containerView.elevate(height: 4)
        containerView.layer.cornerRadius = 10.0
    }
    
    func configure(with repo: Repo) {
        // set title
        titleLabel.text = repo.name
        
        // set visibiliy label
        visibilityLabel.text = repo.visibility
        visibilityLabel.textColor = UIColor(hex: kTealColor)
        
        // set description
        descriptionLabel.text = repo.description
        
        // set language
        let attachment = NSTextAttachment()
        let config = UIImage.SymbolConfiguration(scale: .small)
        let color = self.color(for: repo.language)
        attachment.image = UIImage(systemName: "doc", withConfiguration: config)?.withTintColor(color, renderingMode: .alwaysOriginal)
        let imageString = NSMutableAttributedString(attachment: attachment)
        let textString = NSAttributedString(string: " " + repo.language)
        imageString.append(textString)
        languageLabel.attributedText = imageString
        languageLabel.sizeToFit()
    }
    
    // Helpers
    func color(for language: String) -> UIColor {
        switch language.lowercased() {
        case "swift":
            return .systemRed
        case "objective-c":
            return .systemBlue
        default:
            return .systemGreen
        }
    }
}
