//
//  Sport.swift
//  SportsApp
//
//  Created by Mahmoud Ghoneim on 2/28/22.
//

import Foundation

struct Sports: Codable{
    var sports:[Sport]
}

struct Sport:Codable,Hashable{
    var idSport             : String?
    var strSport            : String?
    var strFormat           : String?
    var strSportThumb       : String?
    var strSportIconGreen   : String?
    var strSportDescription : String?
}
