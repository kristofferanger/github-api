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
        
        // set description
        descriptionLabel.text = repo.description
        
        // set language
        languageLabel.text = repo.language
        
        
        // configure visibiliy label
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "capsule")

        let imageString = NSMutableAttributedString(attachment: attachment)
        let textString = NSAttributedString(string: repo.visibility)
        imageString.append(textString)

        visibilityLabel.attributedText = imageString
        visibilityLabel.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
