//
//  DetailHeroViewController.swift
//  SwiftBook_2_HomeWork10.1
//
//  Created by Damir Lutfullin on 19.10.2020.
//

import UIKit

protocol DetailHeroViewProtocol: class {
    var presenter: DetailHeroPresenterProtocol! {get set}
    func setImage(dataForImage: Data)
}


class DetailHeroViewController: UIViewController, DetailHeroViewProtocol {
    
    var presenter: DetailHeroPresenterProtocol!
    var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var heroImage: UIImageView!
    @IBOutlet var backGroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setActivityIndicator()
        view.insertSubview(activityIndicator, aboveSubview: heroImage)
        presenter.setImage()
    }
    
    private func setActivityIndicator() {
        self.activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.frame = CGRect(x: 0, y: 0,
                                         width: UIScreen.main.bounds.size.width,
                                         height: UIScreen.main.bounds.size.height)
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    func setImage(dataForImage: Data) {
        let image = UIImage(data: dataForImage)
        self.backGroundImage.image = image
        self.heroImage.image = image
        self.activityIndicator.stopAnimating()
    }
}



