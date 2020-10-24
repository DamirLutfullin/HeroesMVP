//
//  DetailHeroPresenter.swift
//  SwiftBook_2_HomeWork10.1
//
//  Created by Damir Lutfullin on 19.10.2020.
//

import Foundation

protocol DetailHeroPresenterProtocol: AnyObject {
    init(view: DetailHeroViewProtocol, hero: Hero, network: NetworkManagerProtocol, router: Router)
    func setHero()
}

final class DetailHeroPresenter: DetailHeroPresenterProtocol {
    
    private weak var view: DetailHeroViewProtocol?
    private var hero: Hero
    private var router: RouterProtocol
    private var network: NetworkManagerProtocol
    
    required init(view: DetailHeroViewProtocol, hero: Hero, network: NetworkManagerProtocol, router: Router) {
        self.hero = hero
        self.view = view
        self.network = network
        self.router = router
    }
    
    func setHero() {
        view?.showInfo(hero: hero)
        let imageString = hero.images.lg
        network.downloadImage(urlString: imageString) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.view?.showImage(dataForImage: data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


