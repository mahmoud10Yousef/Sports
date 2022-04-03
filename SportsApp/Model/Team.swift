//
//  Team.swift
//  SportsApp
//
//  Created by Mahmoud Ghoneim on 3/2/22.
//

import Foundation


struct TeamModel:Codable {
    var teams:[Team]
}


struct Team :Codable {
    var strTeam          :String?
    var strDescriptionEN :String?
    var strTeamBadge     :String?
    var strWebsite       :String?
    var strFacebook      :String?
    var strTwitter       :  String?
    var strInstagram     :String?
    var strStadium       :String?
}
