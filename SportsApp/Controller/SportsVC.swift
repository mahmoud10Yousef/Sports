//
//  SportsVC.swift
//  SportsApp
//
//  Created by Mahmoud Ghoneim on 2/28/22.
//

import UIKit
import ProgressHUD

class SportsVC: UIViewController {
    
    enum Section {case main }
    var allSports:[Sport]     = []
    var filteredArray:[Sport] = []
    var isSearching           = false
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var emptyState: EmptyStateView!
    var dataSource: UICollectionViewDiffableDataSource<Section , Sport>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        configureDataSource()
        configureSearchController()
        getSports()
    }
    
    
    private func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        let searchBar = searchController.searchBar
        searchBar.tintColor    = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        searchBar.placeholder  = "Search for a sport"
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.white
            textfield.layer.cornerRadius = 10;
            textfield.clipsToBounds = true;
        }
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.6483632922, green: 0.6378747225, blue: 0.9345269799, alpha: 1)
                   
        navigationItem.searchController = searchController
    }
    
    
    private func getSports(){
        ProgressHUD.show("Loading...")
        NetworkManager.shared.getSports { [weak self] result  in
            ProgressHUD.dismiss()
            guard let self = self else { return }
            switch result{
            case .success(let sports):
                self.allSports = sports
                self.updataData(on: sports)
            case .failure(let error) :
                DispatchQueue.main.async {ProgressHUD.show(error.rawValue)}
            }
        }
    }
    
    
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Sport>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, sport) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SportCell.reuseID, for: indexPath) as! SportCell
            cell.configureCell(with: sport)
            return cell
        })
    }
    
    
    private func updataData(on sports:[Sport]){
       
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Section,Sport>()
            snapshot.appendSections([.main])
            snapshot.appendItems(sports)
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}


extension SportsVC: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationVC = self.storyboard?.instantiateViewController(identifier: "LeaguesVC") as! LeaguesVC
        let selectedSport = isSearching ? filteredArray[indexPath.item] : allSports[indexPath.item]
        destinationVC.leagueName = selectedSport.strSport
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
}


extension SportsVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = self.view.frame.width / 2
        return CGSize(width: itemWidth - 20 , height: itemWidth )
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
}


extension SportsVC : UISearchResultsUpdating{
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        print(searchController.searchBar.text!)
        guard let filter = searchController.searchBar.text , !filter.isEmpty else{
            isSearching = false
            filteredArray.removeAll()
            updataData(on: self.allSports)
            return
        }
        isSearching = true
        filteredArray = allSports.filter({ $0.strSport!.lowercased().contains(filter.lowercased())})
        updataData(on: filteredArray)
    }
    
    
}




