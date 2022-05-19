//
//  HomeWorker.swift
//  bookapp
//
//  Created by Muhammad Hashir Shoaib on 17/05/2022.
//

import Foundation
import UIKit
import CoreData

class HomeWorker {
    
    let api = API()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func markFavourite() {
        
    }
    
    func fetchRandomNumber(onSuccess: @escaping ([CDAstro])->()) throws {
        do {
            let cdAstros =  try context.fetch(CDAstro.fetchRequest())
            print("I got local astros:" , cdAstros.count)
            
            if cdAstros.count > 0 {
                DispatchQueue.main.async {
                    onSuccess(cdAstros)
                    // self.tableView.reloadData()
                }
                return
            }
            
        }
        catch {
            print("ERRRRROOORRR IN COMING")
        }
        
        URLSession.shared.request(url: URL(string: self.api.url), expecting: Response.self) { result in
            switch result {
            case .success(let response):
                var astros = [Astro]()
                response.forEach { astro in
                    if astro.mediaType == MediaType.image {
                        astros.append(astro)
                    }
                }
                print("I got online astros", astros.count)
                DispatchQueue.main.async {
                    let cdAstros = astros.map({ astros in
                        return astros.toManagedObject(in: self.context)
                    })
                    onSuccess(cdAstros)
                }
            case .failure(let error):
                debugPrint("OHOHOHOHOOHO")
                debugPrint(error)
            }
        }
    }
}
