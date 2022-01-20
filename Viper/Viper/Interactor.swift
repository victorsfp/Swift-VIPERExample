//
//  Interactor.swift
//  Viper
//
//  Created by Victor Feitosa on 20/01/22.
//

import Foundation

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    func getUsers()
}

class UserInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUsers() {
        print("Start fetching")
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchUser(with: .failure(FetchError.failed))
                return
            }
            
            do {
                let entities = try JSONDecoder().decode([User].self, from: data)
                self?.presenter?.interactorDidFetchUser(with: .success(entities))
            } catch {
                self?.presenter?.interactorDidFetchUser(with: .failure(FetchError.failed))
            }
            
        }
        
        task.resume()
    }
}

