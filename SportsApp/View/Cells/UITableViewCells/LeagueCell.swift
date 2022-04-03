//
//  LeagueCell.swift
//  SportsApp
//
//  Created by Mahmoud Ghoneim on 2/28/22.
//

import UIKit

class LeagueCell: UITableViewCell {

    static let reuseID = "LeagueCell"
    var presentYoutube: (()->())?
    
    @IBOutlet weak var leagueImageView: UIImageView!{
        didSet{
            leagueImageView.layer.cornerRadius = 10
            leagueImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var youtubeButton: UIButton!{
        didSet{
            youtubeButton.layer.cornerRadius = 30
            youtubeButton.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView! {
        didSet{
            visualEffectView.layer.cornerRadius = 15
            visualEffectView.layer.masksToBounds = true
            visualEffectView.layer.borderWidth = 1
            visualEffectView.layer.borderColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        }
    }
    @IBOutlet weak var leagueNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(for league:League){
        leagueImageView.setImage(with: league.strBadge ?? "")
        leagueNameLabel.text  = league.strLeague
    }
    
    
    @IBAction func youtubeButtonPressed(_ sender: UIButton) {
        presentYoutube?()
    }
    
}
