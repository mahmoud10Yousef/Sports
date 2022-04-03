//
//  TeamsCell.swift
//  SportsApp
//
//  Created by Mahmoud Ghoneim on 3/2/22.
//

import UIKit

class TeamsCell: UICollectionViewCell {
    
    static let reuseID = "TeamsCell"
    
    @IBOutlet weak var teamImageview: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeUI()
    }
   
    
    private func customizeUI(){
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth   = 1
        self.contentView.layer.borderColor   = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    }
    
    
     func configureCell(for team: Team){
        teamImageview.setImage(with: team.strTeamBadge ?? "")
        teamNameLabel.text = team.strTeam
    }
    
}
