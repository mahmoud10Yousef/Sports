//
//  OnboardingCell.swift
//  SportsApp
//
//  Created by Mahmoud Ghoneim on 3/8/22.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    static let reuseID = String(describing: OnboardingCell.self)
    
    @IBOutlet weak var slideImageView        : UIImageView!
    @IBOutlet weak var slidetitlelabel       : UILabel!
    @IBOutlet weak var slideDescriptionlabel : UILabel!
    
    
    func configureCell(with slide: OnboardingSlide){
        slideImageView.image       = slide.image
        slidetitlelabel.text       = slide.title
        slideDescriptionlabel.text = slide.description
    }
    
}
