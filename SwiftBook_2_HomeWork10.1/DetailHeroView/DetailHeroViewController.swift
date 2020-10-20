//
//  DetailHeroViewController.swift
//  SwiftBook_2_HomeWork10.1
//
//  Created by Damir Lutfullin on 19.10.2020.
//

import UIKit

class DetailHeroViewController: UIViewController, DetailHeroViewProtocol {
   
    var presenter: DetailHeroPresenterProtocol!
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
    
    @IBOutlet var heroImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.insertSubview(activityIndicator, aboveSubview: heroImage)
        if let imageString = presenter.hero?.images.lg {
            self.heroImage.downloaded(from: imageString) { [weak self] in
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
    func setHero(hero: Hero?) {
        
    }
}



