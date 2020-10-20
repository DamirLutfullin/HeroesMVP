//
//  DetailHeroPresenter.swift
//  SwiftBook_2_HomeWork10.1
//
//  Created by Damir Lutfullin on 19.10.2020.
//

import Foundation

protocol DetailHeroViewProtocol: class {
    var presenter: DetailHeroPresenterProtocol! {get set}
    func setHero(hero: Hero?)
}

protocol DetailHeroPresenterProtocol: AnyObject {
    var view: DetailHeroViewProtocol? { get set }
    var hero: Hero? {get set}
    var router: Router {get set}
    init(view: DetailHeroViewProtocol, hero: Hero, router: Router)
}

class DetailHeroPresenter: DetailHeroPresenterProtocol {
    weak var view: DetailHeroViewProtocol?
    var hero: Hero?
    var router: Router
    
    required init(view: DetailHeroViewProtocol, hero: Hero, router: Router) {
        self.hero = hero
        self.view = view
        self.router = router
    }
}


