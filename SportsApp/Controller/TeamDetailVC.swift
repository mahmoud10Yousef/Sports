//
//  TeamDetailVC.swift
//  SportsApp
//
//  Created by Mahmoud Ghoneim on 3/2/22.
//

import UIKit


enum SocialType:Int{
    case facebook = 1
    case twitter
    case instagram
    case web
}


class TeamDetailVC: UIViewController {
    
    var team:Team!
    
    @IBOutlet weak var teamLogoImageView: UIImageView!
    @IBOutlet weak var teamName        : UILabel!
    @IBOutlet weak var teamStadium     : UILabel!
    @IBOutlet weak var teamDescription : UILabel!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements(for: team)
    }
    
    
    private func configureUIElements(for team:Team){
        teamLogoImageView.setImage(with: team.strTeamBadge ?? "")
        teamName.text = team.strTeam
        teamStadium.text = team.strStadium
        teamDescription.text = team.strDescriptionEN
    }
    
    
    @IBAction func socialButtonClicked(_ sender: UIButton) {
        switch sender.tag {
        
        case SocialType.facebook.rawValue :
            self.openURL(team.strFacebook ?? "")
            
        case SocialType.twitter.rawValue:
            self.openURL(team.strTwitter ?? "")
            
        case SocialType.instagram.rawValue:
            self.openURL(team.strInstagram ?? "")
            
        case SocialType.web.rawValue:
            self.openURL(team.strWebsite ?? "")
            
        default:
            break
        }
    }
    
    

}
