//
//  AssamblyModuleBuilder.swift
//  SwiftBook_2_HomeWork10.1
//
//  Created by Damir Lutfullin on 16.10.2020.
//

import Foundation

protocol AssembliBuilderModuleProtocol: class {
    func createMainHeroScreen(router: Router) -> StartHeroView
    func createDetailHeroScreen(hero: Hero, router: Router) -> DetailHeroViewController
}

final class AssembliBuilderModule: AssembliBuilderModuleProtocol {
    
    func createMainHeroScreen(router: Router) -> StartHeroView {
        let mainHeroViewController = StartHeroView()
        let network = NetworkManager()
        let presenter = StartHeroPresenter(view: mainHeroViewController, network: network, router: router)
        mainHeroViewController.heroPresenter = presenter
        return mainHeroViewController
    }
    
    func createDetailHeroScreen(hero: Hero, router: Router) -> DetailHeroViewController {
        let view = DetailHeroViewController()
        let network = NetworkManager()
        let presenter = DetailHeroPresenter(view: view, hero: hero, network: network, router: router)
        view.presenter = presenter
        return view
    }
}

