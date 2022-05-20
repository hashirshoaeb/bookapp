//
//  DetailRouter.swift
//  bookapp
//
//  Created by Muhammad Hashir Shoaib on 19/05/2022.
//

import Foundation



protocol DetailDataPassing {
    var dataStore: DetailDataStore { get set }
}

protocol DetailDataStore {
    var data: CDAstro? {get set}
}


class DetailRouter: DetailDataPassing {
    
    var dataStore: DetailDataStore
    let viewController: DetailViewController
    
    init(viewController: DetailViewController, dataStore: DetailDataStore){
        self.viewController = viewController
        self.dataStore = dataStore
    }
}
