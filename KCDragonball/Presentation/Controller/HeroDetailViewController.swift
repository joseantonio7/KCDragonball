//
//  HeroDetailViewController.swift
//  KCDragonball
//
//  Created by José Antonio Aravena on 29-09-24.
//

import UIKit

class HeroDetailViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private let hero: Hero
    
    init(hero: Hero) {
        self.hero = hero
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

}

// MARK: - View Configuration
private extension HeroDetailViewController {
    func configureView() {
        label.text = hero.name
        descriptionLabel.text = hero.description
        
        guard let imageURL = URL(string: hero.photo) else {
            return
        }
        
        image.setImage(url: imageURL)
    }
}

