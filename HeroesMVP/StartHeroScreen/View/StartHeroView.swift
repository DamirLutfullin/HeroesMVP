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
    func showCellImage(dataForImage: Data, indexPath: IndexPath)
}

final class StartHeroView: UITableViewController {
    
    //MARK: -Properties
    private var activityIndicator: UIActivityIndicatorView!
    var heroPresenter: StartHeroPresenterProtocol!
    
    //MARK: -Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .black
        setView()
        tableView.register(UINib(nibName: "HeroTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        heroPresenter.setHeroesForView()
    }
    
    //MARK: -Func
    private func setView() {
        tableView.separatorStyle = .none
        self.navigationController?.navigationBar.tintColor = .black
        setBackbroundView()
        setActivityIndicator()
        setBlurEffectForNavigationBar()
    }
    
    private func setBackbroundView() {
        let image = UIImageView(frame: UIScreen.main.bounds)
        image.contentMode = .scaleAspectFill
        image.image = #imageLiteral(resourceName: "heroes")
        tableView.backgroundView = image
        tableView.backgroundColor = .black
        tableView.backgroundView?.alpha = 0.5
    }
    
    private func setActivityIndicator() {
        self.activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.frame = CGRect(x: 0, y: 0,
                                         width: UIScreen.main.bounds.size.width,
                                         height: UIScreen.main.bounds.size.height)
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        tableView.addSubview(activityIndicator)
    }
    
    private func setBlurEffectForNavigationBar() {
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
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
    func showCellImage(dataForImage: Data, indexPath: IndexPath) {
        
        //так как мы листаем быстро, на момент получения картинки ячейки по данному индексу может уже не существовать, и попытка установки картинки приведет к падению из за обращения к нилу
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


