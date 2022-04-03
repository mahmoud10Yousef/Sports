//
//  NetworkManager.swift
//  SportsApp
//
//  Created by Mahmoud Ghoneim on 2/24/22.
//

import Foundation

class NetworkManager{
    
    static let shared = NetworkManager()
    
    private init(){}
    
    func getSports(completed: @escaping(Result<[Sport] , ErrorMessage>) -> Void){
        let endPoint = "https://www.thesportsdb.com/api/v1/json/2/all_sports.php"
        guard let url = URL(string:endPoint) else{
            completed(.failure(.unableToComplete))
           return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let allSports = try JSONDecoder().decode(Sports.self, from: data)
                completed(.success(allSports.sports))
            }catch{
                completed(.failure(.invalidData))
            }
        }.resume()
    }
    
    // https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?c=England&s=Soccer
    
    func getLeagues(for sport :String , completed: @escaping(Result<[League] , ErrorMessage>) -> Void){
        let endPoint = "https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?c=England&s=\(sport)"
        guard let url = URL(string:endPoint) else{
            completed(.failure(.unableToComplete))
           return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let leagues = try JSONDecoder().decode(LeagueModel.self, from: data)
                guard let allLeagues = leagues.countrys else { return}
                completed(.success(allLeagues))
            }catch{
                completed(.failure(.invalidData))
            }
        }.resume()
    }
    
    
    func getEvents(for legueId :String , round:String, completed: @escaping(Result<[Event] , ErrorMessage>) -> Void){
        let endPoint = "https://www.thesportsdb.com/api/v1/json/2/eventsround.php?id=\(legueId)&r=\(round)&s=2021-2022"
        guard let url = URL(string:endPoint) else{
            completed(.failure(.unableToComplete))
           return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let events = try JSONDecoder().decode(Events.self, from: data)
                completed(.success(events.events))
            }catch{
                completed(.failure(.invalidData))
            }
        }.resume()
    }
    
    
    func getTeams(completed: @escaping(Result<[Team] , ErrorMessage>) -> Void){
        let endPoint = "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?s=Soccer&c=England"
        guard let url = URL(string:endPoint) else{
            completed(.failure(.unableToComplete))
           return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let teams = try JSONDecoder().decode(TeamModel.self, from: data)
                completed(.success(teams.teams))
            }catch{
                completed(.failure(.invalidData))
            }
        }.resume()
    }
    
    
}
