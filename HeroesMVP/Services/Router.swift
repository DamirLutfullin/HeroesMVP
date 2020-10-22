//
//  Router.swift
//  SwiftBook_2_HomeWork10.1
//
//  Created by Damir Lutfullin on 16.10.2020.
//

import UIKit

protocol  RouterMain {
    var navigationController: UINavigationController {get set}
    var assembliBuilder: AssembliBuilderModuleProtocol {get set}
    
    init(navigationController: UINavigationController, assembliBuilder: AssembliBuilderModuleProtocol)
}

protocol RouterProtocol: RouterMain {
    func createInitialViewController()
    func pushDetailViewController(hero: Hero)
    func popToRoot()
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController
    var assembliBuilder: AssembliBuilderModuleProtocol
    
    required init(navigationController: UINavigationController, assembliBuilder: AssembliBuilderModuleProtocol) {
        self.navigationController = navigationController
        self.assembliBuilder = assembliBuilder
    }
    
    func createInitialViewController() {
        let viewController = assembliBuilder.createMainHeroScreen(router: self)
        navigationController.viewControllers = [viewController]
    }
    
    func pushDetailViewController(hero: Hero) {
        let detailHerpViewController = assembliBuilder.createDetailHeroScreen(hero: hero, router: self)
        navigationController.pushViewController(detailHerpViewController, animated: true)
    }
    
    func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
}
