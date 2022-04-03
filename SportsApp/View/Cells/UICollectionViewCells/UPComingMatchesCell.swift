//
//  UPComingMatchesCell.swift
//  SportsApp
//
//  Created by Mahmoud Ghoneim on 3/1/22.
//

import UIKit

class UPComingMatchesCell: UICollectionViewCell {
    
    static let reuseID = "UPComingMatchesCell"
    
    @IBOutlet weak var teamsLabel: UILabel!
    @IBOutlet weak var upcomingMatchImageView: UIImageView!
    @IBOutlet weak var upcomingMatchDetailLabel: UILabel!
    
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var eventDatelabel: UILabel!
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
        upcomingMatchImageView.setImage(with: event.strThumb ?? "")
        upcomingMatchDetailLabel.text = event.strFilename
        teamsLabel.text = event.strEvent
        eventDatelabel.text = event.dateEvent
        eventTimeLabel.text = "Start Time:  \(event.strTime!)"
        
    }

}
