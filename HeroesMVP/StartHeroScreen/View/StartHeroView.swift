//
//  MainHeroView.swift
//  SwiftBook_2_HomeWork10.1
//
//  Created by Damir Lutfullin on 18.10.2020.
//

import UIKit

//MARK: - StartHeroViewProtocol
protocol StartHeroViewProtocol: class {
    func showHeroes()
    func showError(error: Error)
    func setImage(dataForImage: Data, indexPath: IndexPath)
}

class StartHeroView: UITableViewController {
    
    var heroPresenter: StartHeroPresenterProtocol!
    var activityIndicator: UIActivityIndicatorView!
    var dataForImage: Data?
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()

        tableView.register(UINib(nibName: "HeroTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        heroPresenter.setHeroesForView()
        
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    //MARK: - func
    private func setView() {
        tableView.separatorStyle = .none
        self.navigationController?.navigationBar.tintColor = .black
        setActivityIndicator()
        setBlurEffectForNavigationBar()
    }
    
    private func setActivityIndicator() {
        self.activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.frame = CGRect(x: 0, y: 0,
                                         width: UIScreen.main.bounds.size.width,
                                         height: UIScreen.main.bounds.size.height)
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        tableView.addSubview(activityIndicator)
    }
    
    private func setBlurEffectForNavigationBar() {
        let visualEffectView   = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.frame =  (self.navigationController?.navigationBar.bounds.insetBy(dx: 0, dy: -10).offsetBy(dx: 0, dy: -10))!
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.addSubview(visualEffectView)
        self.navigationController?.navigationBar.sendSubviewToBack(visualEffectView)
        visualEffectView.layer.zPosition = -1;
        visualEffectView.isUserInteractionEnabled = false
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
        if let hero = heroPresenter.heroes?[indexPath.row],
           let task = heroPresenter.setImageForCell(hero: hero, cellIndex: indexPath) {
            cell.configurate(hero: hero, task: task)
        }
        return cell
    }
}

