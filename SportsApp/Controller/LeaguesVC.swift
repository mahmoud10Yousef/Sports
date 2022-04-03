//
//  LeaguesVC.swift
//  SportsApp
//
//  Created by Mahmoud Ghoneim on 2/28/22.
//

import UIKit
import ProgressHUD
import SafariServices

class LeaguesVC: UIViewController {
    
    var leagueName:String!
    var leagues:[League] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = leagueName
        configuretableview()
        getLeagues(for: leagueName)
    }
    
    
    private func getLeagues(for sport: String){
        ProgressHUD.show("Loading...")
        NetworkManager.shared.getLeagues(for: sport) { [weak self] result in
            
            guard let self = self else { return }
            ProgressHUD.dismiss()
            
            switch result{
            case .success(let leagues):
                self.updateUI(for: leagues)
            case .failure(let error):
                DispatchQueue.main.async {ProgressHUD.showError(error.rawValue, interaction: true)}
            }
        }
    }
    
    
    private func updateUI(for leagues:[League]){
        self.leagues = leagues
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
    
    
    private func configuretableview(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 140
    }
    
}


extension LeaguesVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detinationVC = self.storyboard?.instantiateViewController(withIdentifier: "EventVC") as! EventVC
        detinationVC.league = leagues[indexPath.row]
        self.navigationController?.pushViewController(detinationVC, animated: true)
        
    }
}


extension LeaguesVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        leagues.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeagueCell.reuseID, for: indexPath) as! LeagueCell
        cell.configureCell(for: leagues[indexPath.row])
        cell.presentYoutube = {self.openURL(self.leagues[indexPath.row].strYoutube ?? "")}
        
        return cell
    }
    
    
}
