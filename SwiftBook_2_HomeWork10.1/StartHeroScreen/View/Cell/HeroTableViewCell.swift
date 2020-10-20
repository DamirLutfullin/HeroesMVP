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
    
    func configurateCell(hero: Hero) {
        fullName.text = hero.name
        intelligence.text = hero.powerstats.intelligence.description
        durability.text = hero.powerstats.durability.description
        strength.text = hero.powerstats.strength.description
        speed.text = hero.powerstats.speed.description
        
        let urlString = hero.images.md
        guard let url = URL(string: urlString) else { return }
        task = imageTask(for: url, completion: { (result) in
            switch result {
            case .success(let image):
                self.heroImageView.image = image
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
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
    
    @discardableResult
    func imageTask(for url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) -> URLSessionTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode,
                  let image = UIImage(data: data) else {
                DispatchQueue.main.async { completion(.failure(error!)) }
                return
            }
            DispatchQueue.main.async { completion(.success(image)) }
        }
        task.resume()
        return task
    }
}
