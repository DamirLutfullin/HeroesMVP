//
//  HeroTableViewCell.swift
//  SwiftBook_2_HomeWork10.1
//
//  Created by Damir Lutfullin on 18.10.2020.
//

import UIKit

class HeroTableViewCell: UITableViewCell {
    
    private weak var task: URLSessionTask?
    
    @IBOutlet var heroImageView: UIImageView!
    @IBOutlet var fullName: UILabel!
    @IBOutlet var intelligence: UILabel!
    @IBOutlet var durability: UILabel!
    @IBOutlet var strength: UILabel!
    @IBOutlet var speed: UILabel!
    
    func configurateCell(hero: Hero, task: URLSessionTask) {
        self.task = task
        fullName.text = hero.name
        intelligence.text = hero.powerstats.intelligence.description
        durability.text = hero.powerstats.durability.description
        strength.text = hero.powerstats.strength.description
        speed.text = hero.powerstats.speed.description
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        task?.cancel()
        self.heroImageView?.image = #imageLiteral(resourceName: "Снимок экрана 2020-10-18 в 07.34.36")
        self.durability.text = nil
        self.fullName.text = nil
        self.intelligence.text = nil
        self.speed.text = nil
        self.strength.text = nil
    }
    
    func setImage(data: Data) {
        self.heroImageView.image = UIImage(data: data)
    }
}
