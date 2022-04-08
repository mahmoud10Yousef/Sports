//
//  EventVC.swift
//  SportsApp
//
//  Created by Mahmoud Ghoneim on 3/1/22.
//

import UIKit
import ProgressHUD

class EventVC: UIViewController {
    
    
    @IBOutlet weak var collectionView:UICollectionView!
    
    var league: League!
    var upComingEvents:[Event] = []
    var latestEvents : [Event] = []
    var teams        : [Team]  = []
    var isFavorite     = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
    
        getUpComingEvents(leagueID: self.league.idLeague ?? "1234", round: "28")
        getLatestEvents(leagueID: self.league.idLeague ?? "1234", round: "25")
        getTeams()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureFavoriteIcon()
    }
    
    private func configureFavoriteIcon(){
        isFavorite = CoreDataManager.shared.isInFavorites(leagueID: self.league.idLeague!)
        
        let favoriteBarButtonItem = UIBarButtonItem(image: UIImage(systemName: isFavorite ? "suit.heart.fill": "suit.heart"), style: .plain, target: self, action: #selector(favoriteButtonClicked(sender:)))
        favoriteBarButtonItem.tintColor = .red
        
        navigationItem.rightBarButtonItem = favoriteBarButtonItem
    }
    
    
    @objc func favoriteButtonClicked(sender:UIBarButtonItem){
        isFavorite.toggle()
        let imageName = isFavorite ? "suit.heart.fill" : "suit.heart"
        sender.image = UIImage(systemName: imageName)
        if isFavorite{
            CoreDataManager.shared.addToFavorites(league: self.league)
            ProgressHUD.showSuccess("League saved to favorites successfully")
        }else{
            CoreDataManager.shared.removeFromFavorites(leagueID: self.league.idLeague!)
            ProgressHUD.showSuccess("League is removed from favorites successfully")
        }
        
    }
    
    
    private func getUpComingEvents(leagueID:String , round: String ){
        ProgressHUD.show("Loading...")
        NetworkManager.shared.getEvents(for: self.league.idLeague ?? "1234", round: round) { [weak self](result) in
            guard let self = self else { return }
            ProgressHUD.dismiss()
            switch result{
            case .success(let events):
                self.updateEventsUI(with: events)
            case .failure(let error):
                DispatchQueue.main.async {
                    ProgressHUD.showError(error.rawValue)
                }
            }
        }
    }
    
    
    private func getLatestEvents(leagueID:String , round: String ){
        ProgressHUD.show("Loading...")
        NetworkManager.shared.getEvents(for: self.league.idLeague ?? "1234" , round: round) { [weak self](result) in
            guard let self = self else { return }
            ProgressHUD.dismiss()
            switch result{
            case .success(let events):
                DispatchQueue.main.async {
                    self.latestEvents = events
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    ProgressHUD.showError(error.rawValue)
                }
            }
        }
    }
    
    
    func getTeams(){
        
        ProgressHUD.showError("Loading...")
        NetworkManager.shared.getTeams { [weak self] result in
            guard let self = self else { return }
            ProgressHUD.dismiss()
            
            switch result {
            case .success( let teams):
                self.teams = teams
                print(teams.count)
                DispatchQueue.main.async { self.collectionView.reloadData() }
            case .failure(let error):
                DispatchQueue.main.async {ProgressHUD.showError(error.rawValue)}
            }
        }
    }
    
    
    private func updateEventsUI(with events:[Event]){
        self.upComingEvents = events
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    
    private func configureCollectionView(){
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.register(UINib(nibName: HeaderView.reuseID, bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: HeaderView.reuseID)
        collectionView.register(UINib(nibName: UPComingMatchesCell.reuseID, bundle: nil), forCellWithReuseIdentifier: UPComingMatchesCell.reuseID)
        collectionView.register(UINib(nibName: LatestEventsCell.reuseID, bundle: nil), forCellWithReuseIdentifier: LatestEventsCell.reuseID)
        collectionView.register(UINib(nibName: TeamsCell.reuseID, bundle: nil), forCellWithReuseIdentifier: TeamsCell.reuseID)
    }
    
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout  {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] (index, environment) -> NSCollectionLayoutSection? in
            return self?.createSection(for: index, environment: environment)
        })
        return layout
    }
    
    
    private func createSection(for index:Int , environment:NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection{
        switch index {
        case 0:
            return createUpcomingEventSection()
        case 1:
            return createLatestEventSection()
        default:
            return createTeamsSection()
        }
    }
    
    
    private func createUpcomingEventSection()-> NSCollectionLayoutSection{
        let padding:CGFloat = 4
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        let headerView = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [headerView]
        return section
        
    }
    
    
    private func createLatestEventSection()-> NSCollectionLayoutSection{
        let padding:CGFloat = 4
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.25))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        //section.orthogonalScrollingBehavior = .groupPaging
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        let headerView = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [headerView]
        return section
        
    }
    
    
    private func createTeamsSection()-> NSCollectionLayoutSection{
        let padding:CGFloat = 4
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        let headerView = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [headerView]
        return section
    }
    
}


extension EventVC:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return upComingEvents.count
        case 1:
            return latestEvents.count
        default :
            return teams.count
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UPComingMatchesCell.reuseID, for: indexPath) as! UPComingMatchesCell
            cell.configureCell(with: upComingEvents[indexPath.row])
            return cell
        case 1 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LatestEventsCell.reuseID, for: indexPath) as! LatestEventsCell
            cell.configureCell(with: latestEvents[indexPath.row])
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamsCell.reuseID, for: indexPath) as! TeamsCell
            cell.configureCell(for: teams[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: HeaderView.reuseID, for: indexPath) as! HeaderView
        
        switch indexPath.section {
        case 0:
            headerView.setTitle(title: "UPComing Events")
        case 1:
            headerView.setTitle(title: "Latest Events")
        case 2:
            headerView.setTitle(title: "Teams")
        default:
            break
        }
        return headerView
    }
}


extension EventVC: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetailVC") as! TeamDetailVC
        destinationVC.team = self.teams[indexPath.item]
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
