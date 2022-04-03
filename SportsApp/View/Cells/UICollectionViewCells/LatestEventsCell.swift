//
//  LatestEventsCell.swift
//  SportsApp
//
//  Created by Mahmoud Ghoneim on 3/1/22.
//

import UIKit

class LatestEventsCell: UICollectionViewCell {
    
    static let reuseID = "LatestEventsCell"
    
    @IBOutlet weak var teamsLabel: UILabel!
    @IBOutlet weak var latestEventImageView: UIImageView!
    
    @IBOutlet weak var latestEventResultLabel: UILabel!
    
    @IBOutlet weak var visualView: UIVisualEffectView!{
        didSet{
            visualView.layer.cornerRadius = 10
            visualView.layer.borderWidth  = 2
            visualView.layer.borderColor  = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            visualView.clipsToBounds      = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(with event:Event){
        
        latestEventImageView.setImage(with: event.strThumb ?? "")
        teamsLabel.text = event.strEvent
        guard let homeScore = event.intHomeScore , let awayScore = event.intAwayScore else{
            latestEventResultLabel.text = "postponed"
            return
        }
        latestEventResultLabel.text = "\(homeScore)  - \(awayScore)"
    }
    
}
