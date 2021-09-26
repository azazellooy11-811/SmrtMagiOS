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
        repositoryNameLabel.backgroundColor = UIColor.yellowButtonColor

        return repositoryNameLabel
    }()
    
    lazy var commitsCountLabel: UILabel = {
        let commitsCountLabel = UILabel()
        view.addSubview(commitsCountLabel)
        commitsCountLabel.text = String(selectedModel.count)
        commitsCountLabel.backgroundColor = UIColor.yellowButtonColor

        return commitsCountLabel
    }()
    lazy var smileImage: UIImageView = {
        let smileImage = UIImageView()
        smileImage.contentMode = .scaleAspectFill
        smileImage.image = updatesSmiles(percentage: selectedModel.count)
        view.addSubview(smileImage)
        return smileImage
    }()
    
    lazy var exstraLabel: UILabel = {
        let exstraLabel = UILabel()
        exstraLabel.numberOfLines = 0
        exstraLabel.backgroundColor = UIColor.yellowButtonColor
        exstraLabel.text = "Ты большой молодец! У тебя есть \(selectedModel.count) коммит. Продолжай в том же духе и ты получишь больше наград. Смайлик будет повторять твои эмоции."
        return exstraLabel
    }()
    
    lazy var prizeImage: UIImageView = {
        let prizeImage = UIImageView()
        prizeImage.contentMode = .scaleAspectFill
        prizeImage.image = updatesSmiles(percentage: selectedModel.count)
        view.addSubview(prizeImage)
        return prizeImage
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
        view.addSubview(exstraLabel)
        view.addSubview(prizeImage)
        
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
    
    func updatePrize(percentage: Int) -> UIImage {
        switch percentage {
        case 0...1:
            return UIImage.threeOrder!
        case 1...4:
            return UIImage.twoOrder!
        case 4...100:
            return UIImage.oneOrder!
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
        exstraLabel.snp.makeConstraints{ make in
            make.top.equalTo(smileImage.snp.bottom).offset(20)
            make.right.left.equalToSuperview().inset(25)
            
        }
        prizeImage.snp.makeConstraints { make in
            make.top.equalTo(exstraLabel.snp.bottom).offset(25)
            make.centerX.equalTo(self.view)
            make.height.equalTo(180)
            make.width.equalTo(180)
        }
    }
}
