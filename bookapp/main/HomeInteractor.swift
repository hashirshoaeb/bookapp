//
//  HomeInteractor.swift
//  bookapp
//
//  Created by Muhammad Hashir Shoaib on 18/05/2022.
//

import Foundation


protocol HomeBusinessLogic {
    func markFavourite(indexPath: IndexPath)
    func markUnFavourite(indexPath: IndexPath)
    func astroCount() -> Int
    func getAstro(indexPath: IndexPath) -> CDAstro
    func fetchAstros(request: Home.fetchAstroList.Request)
}

protocol HomeDataStore {
    var astros: [CDAstro] { get }
    var selectedAstro: IndexPath? { get }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    // MARK: - VIP setup
    
    let presenter: HomePresentationLogic
    let worker = HomeWorker()
    
    init(presenter: HomePresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - DataStore
    var astros: [CDAstro] = []
    var selectedAstro: IndexPath? = nil
    
    // MARK: - BusinessLogic
    func markFavourite(indexPath: IndexPath) {
        astros[indexPath.row].isFavourite = true
        presenter.updateRow(at: indexPath)
    }
    
    func markUnFavourite(indexPath: IndexPath) {
        astros[indexPath.row].isFavourite = false
        presenter.updateRow(at: indexPath)
    }
    
    func astroCount() -> Int{
        return astros.count
    }
    
    func getAstro(indexPath: IndexPath) -> CDAstro {
        let index = indexPath.row
        return astros[index]
    }
    
    func fetchAstros(request: Home.fetchAstroList.Request) {
        do {
            try worker.fetchRandomNumber { astros in
                self.astros = astros
                self.presenter.updateTable(astros: astros)
            }
        } catch {
            print("OHHH NOO no no")
        }
        
    }
    
}
