//
//  DetailHeroViewController.swift
//  SwiftBook_2_HomeWork10.1
//
//  Created by Damir Lutfullin on 19.10.2020.
//

import UIKit

protocol DetailHeroViewProtocol: class {
    func showImage(dataForImage: Data)
    func showInfo(hero: Hero)
}

final class DetailHeroViewController: UIViewController, DetailHeroViewProtocol {
    
    //MARK: - properties
    private var activityIndicator: UIActivityIndicatorView!
    var presenter: DetailHeroPresenterProtocol!
    
    //MARK: - IBOutlets
    @IBOutlet var heroImage: UIImageView!
    @IBOutlet var backGroundImage: UIImageView!
    
    @IBOutlet var intelligenceLabel: UILabel!
    @IBOutlet var strengthLabel: UILabel!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var durabilityLabel: UILabel!
    @IBOutlet var powerLabel: UILabel!
    @IBOutlet var combatLabel: UILabel!
    
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var raceLabel: UILabel!
    @IBOutlet var heightByCm: UILabel!
    @IBOutlet var weightByKg: UILabel!
    
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var alterEgosLabel: UILabel!
    @IBOutlet var aliasesLabel: UILabel!
    @IBOutlet var firstAppearanceLabel: UILabel!
    @IBOutlet var publisherLabel: UILabel!
    @IBOutlet var alignmentLabel: UILabel!
    
    @IBOutlet var occupationLabel: UILabel!
    @IBOutlet var baseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setActivityIndicator()
        view.insertSubview(activityIndicator, aboveSubview: heroImage)
        presenter.setHero()
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
    
    func showImage(dataForImage: Data) {
        let image = UIImage(data: dataForImage)
        self.backGroundImage.image = image
        self.heroImage.image = image
        self.activityIndicator.stopAnimating()
    }
    
    func showInfo(hero superHero: Hero) {
        self.title = superHero.name
        
        let powerstats = superHero.powerstats
        intelligenceLabel.text = "INTELLIGENCE: \(String(powerstats.intelligence))"
        strengthLabel.text = "STRENGTH: \(String(powerstats.strength))"
        speedLabel.text = "SPEED: \(String(powerstats.speed))"
        durabilityLabel.text = "DURABILTY: \(String(powerstats.durability))"
        powerLabel.text = "POWER: \(String(powerstats.power))"
        combatLabel.text = "COMBAT: \(String(powerstats.combat))"
        
        let appearance = superHero.appearance
        genderLabel.text = "GENDER: \(appearance.gender)"
        raceLabel.text = "RACE: \(String(appearance.race ?? "Unknown"))"
        heightByCm.text = "\(appearance.height[1])"
        weightByKg.text = "\(appearance.weight[1])"
        
        let biography = superHero.biography
        fullNameLabel.text = "FULL NAME: \(biography.fullName)"
        alterEgosLabel.text = "ALTER EGOS: \(biography.alterEgos)"
        
        aliasesLabel.text = "ALIASES: \(biography.aliases.joined(separator: ", "))"
        firstAppearanceLabel.text = "FIRST APPEARANCE: \(biography.firstAppearance)"
        publisherLabel.text = "PUBLISHER: \(String(biography.publisher ?? "Unknown"))"
        alignmentLabel.text = "ALIGNMENT: \(biography.alignment)"
        
        let work = superHero.work
        occupationLabel.text = "OCCUPATION: \(work.occupation)"
        baseLabel.text = "BASE: \(work.base)"
    }
}



