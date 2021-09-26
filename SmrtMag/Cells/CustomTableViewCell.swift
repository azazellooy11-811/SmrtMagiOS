//
//  CustomTableViewCell.swift
//  SmrtMag
//
//  Created by Азалия on 26.09.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.shadowColor = UIColor.black.cgColor
            containerView.layer.cornerRadius = 15
            containerView.layer.shadowRadius = 5
            containerView.layer.shadowOpacity = 0.2
            containerView.layer.shadowOffset = CGSize(width: 1, height: 1)
        }
    }
    
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var commitsCountLabel: UILabel!
    
    func configureCell(name: String, commits: Int) {
        repositoryNameLabel.text = name
        commitsCountLabel.text = "Количество коммитов: " + String(commits)
    }
}
