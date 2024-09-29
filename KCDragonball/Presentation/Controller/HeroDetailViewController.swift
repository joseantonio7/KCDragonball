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
    private let button = UIButton(frame: CGRect(x: 30, y: 700, width: 300, height: 60))
    
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
          

          self.view.addSubview(button)
        configureView()
    }
    
    @objc func buttonAction(sender: UIButton!){
        let viewController = TransformationsListViewController(hero: hero)
        navigationController?.show(viewController, sender: self)
    }
    
}

// MARK: - View Configuration
private extension HeroDetailViewController {
    func configureView() {
        label.text = hero.name
        descriptionLabel.text = hero.description
        
        button.backgroundColor = .blue
        button.setTitle("Transformaciones", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.isHidden = false
        
        guard let imageURL = URL(string: hero.photo) else {
            return
        }
        
        image.setImage(url: imageURL)
        
    }
}

