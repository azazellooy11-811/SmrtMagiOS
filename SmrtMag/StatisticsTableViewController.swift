//
//  StatisticsTableViewController.swift
//  SmrtMag
//
//  Created by Азалия on 21.09.2021.
//

import UIKit

class StatisticsTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var models: [Model]?
    var author: String!
    private var remoteDataManager: RemoteDataManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
