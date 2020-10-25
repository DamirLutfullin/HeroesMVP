//
//  MainHeroView.swift
//  SwiftBook_2_HomeWork10.1
//
//  Created by Damir Lutfullin on 18.10.2020.
//

import UIKit

//MARK: - StartHeroViewProtocol
protocol StartHeroViewProtocol: class {
    func showHeroes(heroes: [Hero]?)
    func showError(error: Error)
    func showCellImage(dataForImage: Data, indexPath: IndexPath)
}

final class StartHeroView: UITableViewController {
    
    //MARK: -Properties
    private var activityIndicator: UIActivityIndicatorView!
    private let search = UISearchController(searchResultsController: nil)
    private var heroes: [Hero]? = []
    var heroPresenter: StartHeroPresenterProtocol!
    
    //MARK: -Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "HeroTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        heroPresenter.setHeroesForView()
        setView()
    }
    
    //MARK: -Func
    private func setView() {
        setNavigationBar()
        setBackbroundView()
        setActivityIndicator()
        setSearchController()
    }
    
    private func setSearchController() {
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = true
        tableView.keyboardDismissMode = .onDrag
        
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "enter hero name"
        search.definesPresentationContext = false
    }
    
    private func setNavigationBar() {
        title = "Heroes"
        tableView.separatorStyle = .none
        navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.5882352941, blue: 0, alpha: 1)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))]
        
        //set large title
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))]
    }
    
    private func setBackbroundView() {
        let image = UIImageView(frame: UIScreen.main.bounds)
        image.contentMode = .scaleAspectFill
        image.image = #imageLiteral(resourceName: "heroes")
        tableView.backgroundView = image
        tableView.backgroundColor = .black
        tableView.backgroundView?.alpha = 0.1
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
}

//MARK: - StartHeroViewProtocol
extension StartHeroView: StartHeroViewProtocol {
    
    func showHeroes(heroes: [Hero]?) {
        self.heroes = heroes
        tableView.reloadData()
        activityIndicator.stopAnimating()
    }
    
    func showCellImage(dataForImage: Data, indexPath: IndexPath) {
        //так как мы листаем быстро, на момент получения картинки ячейки по данному индексу может уже не существовать, и попытка установки картинки приведет к падению из за обращения к нилу
        guard let cell = tableView.cellForRow(at: indexPath) as? HeroTableViewCell else { return }
        cell.setImage(data: dataForImage)
    }
    
    func showError(error: Error) {
        activityIndicator.stopAnimating()
        print(error.localizedDescription)
    }
}

//MARK: - UITableViewDelegate
extension StartHeroView {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            if let hero = heroes?[indexPath.row] {
                heroPresenter.showDetailView(hero: hero)
            
        }
    }
}

//MARK: - UITableViewDataSource
extension StartHeroView {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HeroTableViewCell
        if let hero = heroes?[indexPath.row],
           let task = heroPresenter.setImageForCell(hero: hero, cellIndex: indexPath) {
            cell.configurate(hero: hero, task: task)
        }
        return cell
    }
}

//MARK: - UISearchResultsUpdating
extension StartHeroView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        heroPresenter.setFilteresHeroes(searchQuery: text)
    }
}

extension StartHeroView: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        heroPresenter.setHeroesForView()
    }
}


