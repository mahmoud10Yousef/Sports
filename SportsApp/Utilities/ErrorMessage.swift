//
//  ErrorMessage.swift
//  SportsApp
//
//  Created by Mahmoud Ghoneim on 2/28/22.
//

import Foundation


enum ErrorMessage : String , Error {
    
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
    case unableToFavorite   = "This was an error favoriting this user , Please try again"
    case alreadyInFavorites = "You 've already favorited this user. You must REALLY like them."
    
}

