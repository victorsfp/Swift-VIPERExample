//
//  Presenter.swift
//  Viper
//
//  Created by Victor Feitosa on 20/01/22.
//

import Foundation

enum FetchError: Error {
    case failed
}

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func interactorDidFetchUser(with result: Result<[User], Error>)
}

class UserPresenter: AnyPresenter {
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getUsers()
        }
    }
    var router: AnyRouter?
    var view: AnyView?
    
//    init(){
//        interactor?.getUsers()
//    }
    
    func interactorDidFetchUser(with result: Result<[User], Error>) {
        switch result {
            case .success(let users):
                view?.update(with: users)
            case .failure:
            view?.update(with: "Something went wrong")
        }
    }
    
    
    
}
