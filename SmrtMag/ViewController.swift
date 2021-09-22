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
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [githubLoginText,inputLinkTextField,analyzeButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 11
        view.addSubview(stackView)

        return stackView
    }()
    
    lazy var githubLoginText: UILabel = {
        let githubLoginText = UILabel()
        view.addSubview(githubLoginText)
        githubLoginText.textColor = .black
        githubLoginText.text = "Register"
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
    
    lazy var analyzeButton: UIButton = {
        let analyzeButton = UIButton(type: .system)
        analyzeButton.setTitleColor(.white, for: .normal)
        analyzeButton.layer.cornerRadius = 30
        analyzeButton.backgroundColor = UIColor.yellowButtonColor
        analyzeButton.setTitle("Анализировать", for: .normal)
        view.addSubview(analyzeButton)

        return analyzeButton
    }()
    
    private var remoteDataManager: RemoteDataManager!
    private var models: [Model]?
    
    override func viewDidLoad() {

        super.viewDidLoad()
        initialize()
        remoteDataManager = RemoteDataManagerImplementation()
        
        analyzeButton.layer.cornerRadius = analyzeButton.frame.height / 2
    }
   
    private func initialize(){
        view.backgroundColor = UIColor.blueBackgroundColor
        view.addSubview(githubLoginText)
        view.addSubview(inputLinkTextField)
        view.addSubview(analyzeButton)
    }

    @IBAction func analyzeButtonPressed(_ sender: Any) {
        if inputLinkTextField.hasText {
            self.performSegue(withIdentifier: "tableVCSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tableVCSegue"{
            if let statisticsTableViewController = segue.destination as? StatisticsTableViewController {
                statisticsTableViewController.author = inputLinkTextField.text
            }
        }
    }
}
