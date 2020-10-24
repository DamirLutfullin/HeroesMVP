//
//  HeroTableViewCell.swift
//  SwiftBook_2_HomeWork10.1
//
//  Created by Damir Lutfullin on 18.10.2020.
//

import UIKit

final class HeroTableViewCell: UITableViewCell {
    
    // для отмены загрузки картинки в случае пролистывания
    private weak var task: URLSessionTask?
    
    @IBOutlet var containerViewForCell: UIView!
    @IBOutlet var heroImageView: UIImageView!
    @IBOutlet var fullName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.containerViewForCell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
        heroImageView.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        heroImageView.layer.cornerRadius = 15
        containerViewForCell.layer.cornerRadius = 15
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        //отменяет загрузку картинки, если пропала необходимость
        task?.cancel()
        self.heroImageView?.image = #imageLiteral(resourceName: "Снимок")
        self.fullName.text = nil
    }
    
    func configurate(hero: Hero, task: URLSessionTask) {
        self.task = task
        fullName.text = hero.name
    }
    
    func setImage(data: Data) {
        self.heroImageView.image = UIImage(data: data)
    }
}
