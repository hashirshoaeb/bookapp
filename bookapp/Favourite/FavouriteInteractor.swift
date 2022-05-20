//
//  FavouriteInteractor.swift
//  bookapp
//
//  Created by Muhammad Hashir Shoaib on 19/05/2022.
//

import Foundation

protocol FavouriteBusinessLogic {
    func markFavourite(indexPath: IndexPath)
    func markUnFavourite(indexPath: IndexPath)
    func astroCount() -> Int
    func getAstro(indexPath: IndexPath) -> CDAstro
    func setSelectedAstro(index: IndexPath)
}

protocol FavouriteDataStore {
    var astros: [CDAstro] { get set }
    var selectedAstro: CDAstro? { get set }
}

class FavouriteInteractor: FavouriteBusinessLogic, FavouriteDataStore {
    // MARK: - VIP setup
    
    let presenter: FavouritePresentationLogic
    let worker = HomeWorker()
    
    init(presenter: FavouritePresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - DataStore
    var astros: [CDAstro] = []
    var selectedAstro: CDAstro? = nil
    
    // MARK: - BusinessLogic
    func markFavourite(indexPath: IndexPath) {
        astros[indexPath.row].isFavourite = true
        worker.markFavourite()
        presenter.updateRow(at: indexPath)
    }
    
    func markUnFavourite(indexPath: IndexPath) {
        astros[indexPath.row].isFavourite = false
        worker.markUnFavourite()
        presenter.updateRow(at: indexPath)
    }
    
    func astroCount() -> Int{
        return astros.count
    }
    
    func setSelectedAstro(index: IndexPath) {
        selectedAstro = getAstro(indexPath: index)
    }
    
    func getAstro(indexPath: IndexPath) -> CDAstro {
        let index = indexPath.row
        return astros[index]
    }
}
