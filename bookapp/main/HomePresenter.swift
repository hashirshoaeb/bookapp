//
//  HomePresenter.swift
//  bookapp
//
//  Created by Muhammad Hashir Shoaib on 18/05/2022.
//

import Foundation

protocol HomePresentationLogic {
    func updateTable(astros: [CDAstro])
    func updateRow(at: IndexPath)
}

class HomePresenter: HomePresentationLogic {
    
    // MARK: - VIP setup
    
    let viewController: HomeDisplayLogic
    
    init(viewController: HomeDisplayLogic) {
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
