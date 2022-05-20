//
//  HomeRouter.swift
//  bookapp
//
//  Created by Muhammad Hashir Shoaib on 19/05/2022.
//

import Foundation
import UIKit

protocol HomeRoutingLogic {
    func routeToDetailScreen(segue: UIStoryboardSegue?)
    func routeToFavouriteScreen(segue: UIStoryboardSegue?)
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore { get set }
}

class HomeRouter: HomeRoutingLogic, HomeDataPassing {
    
    // MARK: VIP setup
    
    let viewController: HomeViewController
    var dataStore: HomeDataStore
    
    init(viewController: HomeViewController, dataStore: HomeDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
    
    // MARK: Routing Logic
    
    func routeToDetailScreen(segue: UIStoryboardSegue?) {
        // todo refactor
        if let segue = segue {
            let destinationVC = segue.destination as! DetailViewController
            var destinationDS = destinationVC.router.dataStore
            passDataToDetailView(source: dataStore , destination: &destinationDS)
        }
    }
    
    func routeToFavouriteScreen(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! FavouriteViewController
            var destinationDS = destinationVC.router.dataStore
            passDataToFavouriteView(source: dataStore, destination: &destinationDS)
        }
    }
    
    func passDataToFavouriteView(source: HomeDataStore, destination: inout FavouriteDataStore) {
        destination.astros = dataStore.astros.filter({ astro in
            return astro.isFavourite
        })
    }
    
    func passDataToDetailView(source: HomeDataStore, destination: inout DetailDataStore) {
        destination.data = source.selectedAstro
    }
}
