//
//  SportCell.swift
//  SportsApp
//
//  Created by Mahmoud Ghoneim on 2/28/22.
//

import UIKit

class SportCell: UICollectionViewCell {
    
    static let reuseID = "SportCell"
    
    @IBOutlet weak var sportImageView: UIImageView!
    @IBOutlet weak var sportNameLabel: UILabel!
    
    
    private func customizeUI(){
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth   = 1
        self.contentView.layer.borderColor   = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    }
    
    
    func configureCell(with sport: Sport){
        customizeUI()
        sportImageView.setImage(with: sport.strSportThumb!)
        sportNameLabel.text = sport.strSport
    }
    
}
