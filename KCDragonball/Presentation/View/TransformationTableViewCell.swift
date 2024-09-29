//
//  TransformationTableViewCell.swift
//  KCDragonball
//
//  Created by José Antonio Aravena on 29-09-24.
//

import UIKit

class TransformationTableViewCell: UITableViewCell {

    @IBOutlet weak var transformationImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static let identifier = String(describing: TransformationTableViewCell.self)

    func configure(with transformation: Transformation) {

        nameLabel.text = transformation.name
        descriptionLabel.text = transformation.description
        
        guard let imageURL = URL(string: transformation.photo) else {
            return
        }
        transformationImageView.setImage(url: imageURL)
    }
    
}
