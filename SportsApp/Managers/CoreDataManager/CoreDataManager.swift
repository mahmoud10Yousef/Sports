//
//  CoreDataManager.swift
//  SportsApp
//
//  Created by Mahmoud Ghoneim on 3/3/22.
//

import Foundation




import UIKit
import CoreData

class CoreDataManager{
    
    
    static let shared = CoreDataManager()
    private var managedContext: NSManagedObjectContext?
    
    
    private init(){
        guard let appDelegate =  UIApplication.shared.delegate as? AppDelegate else { return }
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    
    func addToFavorites(league:League){
        
        let favoriteEntity = NSEntityDescription.entity(forEntityName: "FavouriteLeagues", in: managedContext!)
        let favLeague = NSManagedObject(entity: favoriteEntity!, insertInto: managedContext!)
        
        
        favLeague.setValue(league.idLeague, forKey: "leagueId")
        favLeague.setValue(league.strLeague, forKey: "leagueName")
        favLeague.setValue(league.strYoutube, forKey: "youtubePath")
        favLeague.setValue(league.strBadge, forKey: "imgPath")
        do{
            try managedContext?.save()
            print("league is save successfully")
        }catch{
            print("error while saving league locally")
        }
        
    }
    
    
    func isInFavorites(leagueID:String)->Bool{
        var results = [NSManagedObject]()
        
        let fetchReaquest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteLeagues")
        fetchReaquest.predicate = NSPredicate(format: "leagueId == %@", leagueID)
        
        do{
            results = try managedContext?.fetch(fetchReaquest) as! [NSManagedObject]
           print("league is in favorites")
        }catch{
            print("error while checking")
        }
        
        return results.count > 0
    }
    
    
    func removeFromFavorites(leagueID:String){
        let fetchReaquest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteLeagues")
        fetchReaquest.predicate = NSPredicate(format: "leagueId == %@", leagueID)
        
        do{
            let objectToDelete = try managedContext?.fetch(fetchReaquest).first as! NSManagedObject
            managedContext?.delete(objectToDelete)
            try managedContext?.save()
           print("delete league successfully")
        }catch{
            print("error while deleteing")
        }
    }
    
    
    func retriveFavorites() -> [League]{
        var favorites = [League]()
        
        let fetchReaquest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteLeagues")
        do{
            let results = try managedContext?.fetch(fetchReaquest) as! [NSManagedObject]
            
            for favorite in results{
                let leagueID    = favorite.value(forKey: "leagueId") as! String
                let strLeague   = favorite.value(forKey: "leagueName") as! String
                let youtubePath = favorite.value(forKey: "youtubePath") as! String
                let imagePath   = favorite.value(forKey: "imgPath") as! String
                let favLeague = League(strLeague: strLeague , idLeague: leagueID , strBadge: imagePath, strYoutube: youtubePath)
                favorites.append(favLeague)
                
            }
            try managedContext?.save()
           print("fetch leagues successfully")
        }catch{
            print("error while fetching leagues")
        }
        return favorites
    }
    
    
}
