//
//  Event.swift
//  SportsApp
//
//  Created by Mahmoud Ghoneim on 3/1/22.
//

import Foundation

struct Events:Codable {
    var events:[Event]
}

struct Event:Codable{
    var strFilename  :String?
    var strThumb     : String?
    var strEvent     : String?
    var strLeague    : String?
    var dateEvent    : String?
    var strTime      : String?
    var intHomeScore :String?
    var intAwayScore :String?
}
