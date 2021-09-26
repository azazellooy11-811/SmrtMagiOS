//
//  RemoteDataManager.swift
//  SmrtMag
//
//  Created by Азалия on 21.09.2021.
//

import Foundation
import Alamofire

protocol RemoteDataManager: AnyObject {
    func getRepositories(author: String, completion: @escaping (Result<[RepositoriesResponseModel], Error>) -> Void)
    func getCommits(author: String, completion: @escaping (Result<[Model], Error>) -> Void)
}

class RemoteDataManagerImplementation: RemoteDataManager {
    
    func getRepositories(author: String, completion: @escaping (Result<[RepositoriesResponseModel], Error>) -> Void) {
        let url = "https://api.github.com/users/\(author)/repos"
        AF.request(url, method: .get).response { response in
            if let error = response.error {
                completion(.failure(error))
            }
            
            guard let data = response.data else { return }
            let decoder = JSONDecoder()
            if let repositories = try? decoder.decode([RepositoriesResponseModel].self, from: data) {
                completion(.success(repositories))
            }
        }
    }
    
    func getCommits(author: String, completion: @escaping (Result<[Model], Error>) -> Void) {
        
        self.getRepositories(author: author) { response in
            switch response{
            case .failure(let error):
                print(error)
            case .success(let data):
                var models: [Model] = []
                let myGroup = DispatchGroup()
                for repo in data{
                    myGroup.enter()
                    let url = "https://api.github.com/repos/\(author)/\(repo.name)/commits"
                    AF.request(url, method: .get).response { (response) in
                        if let error = response.error {
                            completion(.failure(error))
                        }
                        
                        guard let data = response.data else { return }
                        let decoder = JSONDecoder()
                        if let commits = try? decoder.decode([CommitsResponseModel].self, from: data) {
                            models.append(Model(name: repo.name, count: commits.count))
//                            print(repo.name + String(commits.count))
                        }
                        myGroup.leave()
                    }
                }
                myGroup.notify(queue: .main) {
                    completion(.success(models))
                }
            }
        }
    }
}
