//
//  ViewController.swift
//  SmrtMag
//
//  Created by Азалия on 21.09.2021.
//

import SnapKit
import UIKit

class ViewController: UIViewController {
    
    //@IBOutlet weak var inputLinkTextField: UITextField!
    //@IBOutlet weak var analyzeButton: UIButton!
    private var remoteDataManager: RemoteDataManager!
    private var models: [Model]?
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [inputLinkTextField])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 11
        
        
        
        return stackView
    }()
    
    lazy var githubLoginText: UILabel = {
        let githubLoginText = UILabel()
        view.addSubview(githubLoginText)
        githubLoginText.textColor = .black
        githubLoginText.text = "Вставьте ссылку:"
        githubLoginText.font = .boldSystemFont(ofSize: 40)
        
        return githubLoginText
    }()
    
    lazy var inputLinkTextField: UITextField = {
        let inputLinkTextField = UITextField()
        inputLinkTextField.borderStyle = .roundedRect
        inputLinkTextField.text = "azazellooy11-811"
        view.addSubview(inputLinkTextField)
        
        return inputLinkTextField
    }()
    
    lazy var analyzeButton: UIButton! = {
        let analyzeButton = UIButton(type: .system)
        analyzeButton.setTitleColor(.black, for: .normal)
        analyzeButton.layer.cornerRadius = 60
        analyzeButton.backgroundColor = UIColor.yellowButtonColor
        analyzeButton.setTitle("Анализировать", for: .normal)
        view.addSubview(analyzeButton)
        analyzeButton.addTarget(self, action: #selector(btnSomeButtonClicked), for: .touchUpInside)
        
        return analyzeButton
    }()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        addViews()
        remoteDataManager = RemoteDataManagerImplementation()
        view.backgroundColor = UIColor.blueBackgroundColor
        analyzeButton.layer.cornerRadius = analyzeButton.frame.height / 2
    }
    func addViews() {
        view.addSubview(stackView)
        view.addSubview(githubLoginText)
        //        view.addSubview(inputLinkTextField)
        view.addSubview(analyzeButton)
        initConstraints()
    }
    
    private func initConstraints() {
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(176)
        }
        
        analyzeButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(stackView.snp.bottom).offset(21)
        }
        githubLoginText.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32.65)
            maker.left.equalToSuperview().inset(16)
        }
    }
    
    @objc func btnSomeButtonClicked(sender: UIButton) {
        
        self.navigationController?.pushViewController(StatisticsTableViewController(authorTest: inputLinkTextField.text ?? ""), animated: true)
        
    }
}


