//
//  League.swift
//  SportsApp
//
//  Created by Mahmoud Ghoneim on 2/28/22.
//

import Foundation

struct LeagueModel: Codable {
  let countrys:[League]?
}


struct League:Codable {
    var strLeague  : String?
    var idLeague   : String?
    var strBadge   : String?
    var strYoutube : String?
}
