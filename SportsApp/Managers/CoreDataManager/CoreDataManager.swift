//
//  CoreDataManager.swift
//  SportsApp
//
//  Created by Mahmoud Ghoneim on 3/3/22.
//

import Foundation




import Foundation
import CoreData

class CoreDataManager{
    
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SportsApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()


    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    

    func fetchData()->[NSManagedObject]{
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest         = NSFetchRequest<NSManagedObject>(entityName: "FavouriteLeagues")
        let arr = try! managedObjectContext.fetch(fetchRequest)
        print(arr.count)
        return arr
    }

    
    func saveData(leauge: League){
        let managedObjectContext = persistentContainer.viewContext
        let entity       = NSEntityDescription.entity(forEntityName: "FavouriteLeagues", in: managedObjectContext)!
        let league       = NSManagedObject(entity: entity, insertInto: managedObjectContext)

        league.setValue(leauge.idLeague, forKey: "leagueId")
        league.setValue(leauge.strLeague, forKey: "leagueName")
        league.setValue(leauge.strYoutube, forKey: "youtubePath")
        league.setValue(leauge .strBadge, forKey: "imgPath")
        
        print("new LeaugesEntity saved")
        do{
            try managedObjectContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

    }
    
    
    func deleteData(leauge: League){
        let managedObjectContext = persistentContainer.viewContext

        let entity       = NSEntityDescription.entity(forEntityName: "FavouriteLeagues", in: managedObjectContext)!
        let league       = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        
        league.setValue(leauge.idLeague, forKey: "leagueId")
        league.setValue(leauge.strLeague, forKey: "leagueName")
        league.setValue(leauge.strYoutube, forKey: "youtubePath")
        league.setValue(leauge.strBadge, forKey: "imgPath")
        managedObjectContext.delete(league)
        saveContext()
    }
    
}
