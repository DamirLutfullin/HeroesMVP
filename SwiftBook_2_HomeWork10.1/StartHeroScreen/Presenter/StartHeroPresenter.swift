//
//  Presenter.swift
//  SwiftBook_2_HomeWork10.1
//
//  Created by Damir Lutfullin on 13.10.2020.
//

import UIKit

protocol StartHeroPresenterProtocol: class {
    var heroes: [Hero]? {get set}
    var router: Router {get set}
    init(view: StartHeroViewProtocol?, network: NetworkManagerProtocol, router: Router)
    func downloadComments()
    func showDetailView(hero: Hero)
    func setImage(hero: Hero, indexPath: IndexPath) -> URLSessionTask?
}

class StartHeroPresenter: StartHeroPresenterProtocol {
    
    var router: Router
    weak var heroView: StartHeroViewProtocol!
    var network: NetworkManagerProtocol!
    var heroes: [Hero]?
    var task: URLSessionTask?
    
    
    required init(view: StartHeroViewProtocol?, network: NetworkManagerProtocol, router: Router) {
        self.heroView = view
        self.network = network
        self.router = router
        self.downloadComments()
    }
    
    func downloadComments() {
        network.getHeroes { [weak self] (result) in
            switch result {
            case .success(let heroes):
                self?.heroes = heroes
                self?.heroView.showHeroes()
            case .failure(let error):
                self?.heroView.showError(error: error)
            }
        }
    }
    
    func showDetailView(hero: Hero) {
        router.pushDetailViewController(hero: hero)
    }
    
    func setImage(hero: Hero, indexPath: IndexPath) -> URLSessionTask? {
        let imageString = hero.images.lg
        self.task = network.downloadImage2(urlString: imageString, indexPath: indexPath) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.heroView?.setImage(dataForImage: data, indexPath: indexPath)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        return task
    }
}
