//
//  StatisticsTableViewController.swift
//  SmrtMag
//
//  Created by Азалия on 21.09.2021.
//

import UIKit

class StatisticsTableViewController: UIViewController {
    
    var models: [Model]?
    //lazy var author = UILabel()
    var author = ""
    
    private var remoteDataManager: RemoteDataManager!
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
                    make.left.top.equalTo(self.view).offset(20)
                    make.right.bottom.equalTo(self.view).offset(-20)
        }
        return tableView
    }()
    
    init(authorTest:String) {
        super.init(nibName: nil, bundle: nil)
        author = authorTest
  
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        view.addSubview(tableView)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        tableView.dataSource = self
        tableView.delegate = self
        
        self.remoteDataManager = RemoteDataManagerImplementation()
        getModels()
    }
     
    
    func getModels() {
        remoteDataManager.getCommits(author: author) { response in
            switch response{
            case .success(let data):
                DispatchQueue.main.async {
                    self.models = data
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
}

extension StatisticsTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return models?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = models![indexPath.row].name + " " + String(models![indexPath.row].count)
        return cell
    }
}
