//
//  ProfileScreenViewController.swift
//  SmrtMag
//
//  Created by Азалия on 26.09.2021.
//

import UIKit

class ProfileScreenViewController: UIViewController {

    lazy var repositoryNameLabel: UILabel = {
        let repositoryNameLabel = UILabel()
        view.addSubview(repositoryNameLabel)
        repositoryNameLabel.text = selectedModel.name
        repositoryNameLabel.backgroundColor = UIColor.white

        return repositoryNameLabel
    }()
    
    lazy var commitsCountLabel: UILabel = {
        let commitsCountLabel = UILabel()
        view.addSubview(commitsCountLabel)
        commitsCountLabel.text = String(selectedModel.count)
        commitsCountLabel.backgroundColor = UIColor.white

        return commitsCountLabel
    }()
    lazy var smileImage: UIImageView = {
        let smileImage = UIImageView()
        smileImage.contentMode = .scaleAspectFill
        smileImage.image = updatesSmiles(percentage: selectedModel.count)
        view.addSubview(smileImage)
        return smileImage
    }()
    
    var selectedModel: Model!
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.blueBackgroundColor
        super.viewDidLoad()
        addViews()
        initConstraints()
    }
    
    private func addViews() {
        view.addSubview(repositoryNameLabel)
        view.addSubview(commitsCountLabel)
        view.addSubview(smileImage)
        
    }
    func updatesSmiles(percentage: Int) -> UIImage {
        switch percentage {
        case 0...1:
            return UIImage.sadImageView!
        case 1...4:
            return UIImage.neutralImageView!
        case 4...100:
            return UIImage.smileImageView!
        default:
            return UIImage()
        }
    }
    
    private func initConstraints() {
        repositoryNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.centerX.equalTo(self.view)
        }
        commitsCountLabel.snp.makeConstraints { make in
            make.top.equalTo(repositoryNameLabel.snp.bottom).offset(25)
            make.centerX.equalTo(self.view)
        }
        smileImage.snp.makeConstraints { make in
            make.top.equalTo(commitsCountLabel.snp.bottom).offset(25)
            make.centerX.equalTo(self.view)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
    }
}
