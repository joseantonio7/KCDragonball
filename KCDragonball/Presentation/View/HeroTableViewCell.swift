//
//  HeroTableViewCell.swift
//  KCDragonball
//
//  Created by José Antonio Aravena on 28-09-24.
//

import UIKit

class HeroTableViewCell: UITableViewCell {

    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroLabel: UILabel!
    @IBOutlet weak var heroDescriptionLabel: UILabel!
    static let identifier = String(describing: HeroTableViewCell.self)
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // TODO: config selected
    }
    
    func configure(with hero: Hero) {

        heroLabel.text = hero.name
        heroDescriptionLabel.text = hero.description
        
        guard let imageURL = URL(string: hero.photo) else {
            return
        }
        heroImageView.setImage(url: imageURL)
    }
}
