//
//  FavoritesVC.swift
//  SportsApp
//
//  Created by Mahmoud Ghoneim on 3/3/22.
//

import UIKit
import CoreData
import ProgressHUD

class FavoritesVC: UIViewController{
    
   
    var leagues = [League]()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuretableview()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchLeagues()
    }
    
    
    private func fetchLeagues(){
        self.leagues =  CoreDataManager.shared.retriveFavorites()
        tableView.reloadData()
    }
    
    
    private func configuretableview(){
        tableView.dataSource = self
        tableView.rowHeight = 140
    }

    
}

extension FavoritesVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        leagues.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeagueCell.reuseID, for: indexPath) as! LeagueCell
        cell.leagueNameLabel.text = leagues[indexPath.row].strLeague
        cell.leagueImageView.setImage(with: leagues[indexPath.row].strBadge ?? "")
        cell.presentYoutube = {self.openURL(self.leagues[indexPath.row].strYoutube ?? "")}
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
        
                tableView.beginUpdates()
                
                let alert = UIAlertController(title: "Delete from favourites", message: "Are you sure you want to delete this item from favorites", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] _ in
                    tableView.deleteRows(at:[indexPath], with: .automatic)
                    CoreDataManager.shared.removeFromFavorites(leagueID: leagues[indexPath.row].idLeague!)
                    self.leagues.remove(at: indexPath.row)
                    tableView.endUpdates()
                    ProgressHUD.showSuccess("Item is deleted successfully")
                    
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                present(alert, animated: true, completion: nil)
                
            }
        }
    
}

