//
//  MainHeroView.swift
//  SwiftBook_2_HomeWork10.1
//
//  Created by Damir Lutfullin on 18.10.2020.
//

import UIKit

protocol StartHeroViewProtocol: class {
    func showHeroes()
    func showError(error: Error)
    func setImage(dataForImage: Data, indexPath: IndexPath)
}

class StartHeroView: UITableViewController {

    var heroPresenter: StartHeroPresenterProtocol!
    var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.frame = CGRect(x: 0, y: 0,
                                         width: UIScreen.main.bounds.size.width,
                                         height: UIScreen.main.bounds.size.height)
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    var dataForImage: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.addSubview(activityIndicator)
        tableView.register(UINib(nibName: "HeroTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
}

//MARK: - StartHeroViewProtocol
extension StartHeroView: StartHeroViewProtocol {
    func setImage(dataForImage: Data, indexPath: IndexPath) {
        self.dataForImage = dataForImage
        guard let cell = tableView.cellForRow(at: indexPath) as? HeroTableViewCell else { return }
        cell.setImage(data: dataForImage)
    }
    
    func showHeroes() {
        tableView.reloadData()
        activityIndicator.stopAnimating()
    }

    func showError(error: Error) {
        activityIndicator.stopAnimating()
        print(error.localizedDescription)
    }
}

//MARK: - UITableViewDelegate
extension StartHeroView {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let hero = heroPresenter.heroes?[indexPath.row] {
            heroPresenter.showDetailView(hero: hero)
        }
    }
}

//MARK: - UITableViewDataSource
extension StartHeroView {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroPresenter.heroes?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HeroTableViewCell
        if let hero = heroPresenter.heroes?[indexPath.row], let task = heroPresenter.setImage(hero: hero, indexPath: indexPath) {
            cell.configurateCell(hero: hero, task: task)
        }
        return cell
    }
}


