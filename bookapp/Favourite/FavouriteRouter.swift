//
//  FavouriteRouter.swift
//  bookapp
//
//  Created by Muhammad Hashir Shoaib on 19/05/2022.
//

import Foundation
import UIKit

protocol FavouriteRoutingLogic {
    func routeToDetailScreen(segue: UIStoryboardSegue?)
}

protocol FavouriteDataPassing {
    var dataStore: FavouriteDataStore { get set }
}

class FavouriteRouter: FavouriteRoutingLogic, FavouriteDataPassing {
    
    // MARK: VIP setup
    
    let viewController: FavouriteViewController
    var dataStore: FavouriteDataStore
    
    init(viewController: FavouriteViewController, dataStore: FavouriteDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
    
    // MARK: Routing Logic
    
    func routeToDetailScreen(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! DetailViewController
            var destinationDS = destinationVC.router.dataStore
            passDataToDetailView(source: dataStore , destination: &destinationDS)
        }
    }
        
    func passDataToDetailView(source: FavouriteDataStore, destination: inout DetailDataStore) {
        destination.data = source.selectedAstro
    }
}
