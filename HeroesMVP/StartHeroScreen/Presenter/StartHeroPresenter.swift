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
    
    func setHeroesForView()
    func showDetailView(hero: Hero)
    func setImageForCell(hero: Hero, cellIndex: IndexPath) -> URLSessionTask?
    
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
    }
    
    func setHeroesForView() {
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
    
    func setImageForCell(hero: Hero, cellIndex: IndexPath) -> URLSessionTask? {
        let imageString = hero.images.lg
        self.task = network.downloadImageForCell(urlString: imageString, indexPath: cellIndex) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.heroView?.setImage(dataForImage: data, indexPath: cellIndex)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        return task
    }
}