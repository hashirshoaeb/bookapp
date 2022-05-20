//
//  FavouritePresenter.swift
//  bookapp
//
//  Created by Muhammad Hashir Shoaib on 19/05/2022.
//

import Foundation

protocol FavouritePresentationLogic {
    func updateTable(astros: [CDAstro])
    func updateRow(at: IndexPath)
}

class FavouritePresenter: FavouritePresentationLogic {
    
    // MARK: - VIP setup
    
    let viewController: FavouriteDisplayLogic
    
    init(viewController: FavouriteDisplayLogic) {
        self.viewController = viewController
    }
    
    // MARK: - PresentationLogic
    
    func updateTable(astros: [CDAstro]) {
        viewController.updateTable(astros: astros)
    }
    
    func updateRow(at: IndexPath) {
        viewController.updateRow(at: at)
    }
}
