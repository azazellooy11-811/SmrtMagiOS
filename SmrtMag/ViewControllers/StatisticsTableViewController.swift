import UIKit

class StatisticsTableViewController: UIViewController {
    
    var models: [Model] = []
    var tempModels: [Model] = [Model(name: "Азалия", count: 10),Model(name: "Азалия", count: 10),Model(name: "Азалия", count: 10),Model(name: "Азалия", count: 10),Model(name: "Азалия", count: 10),Model(name: "Азалия", count: 10),Model(name: "Азалия", count: 10),Model(name: "Азалия", count: 10),Model(name: "Азалия", count: 10),Model(name: "Азалия", count: 10),Model(name: "Азалия", count: 10),Model(name: "Азалия", count: 10)]
    var author = ""
    private var remoteDataManager: RemoteDataManager!
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
        
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
        return models.count
//        return tempModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedModel = models[indexPath.row]
//        let selectedModel = tempModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
        cell.configureCell(name: selectedModel.name, commits: selectedModel.count)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let profileScreenViewController = ProfileScreenViewController()
        profileScreenViewController.selectedModel = models[indexPath.row]
        navigationController?.pushViewController(profileScreenViewController, animated: true)
    }
}
