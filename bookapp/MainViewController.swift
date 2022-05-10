//
//  MainViewController.swift
//  bookapp
//
//  Created by Muhammad Hashir Shoaib on 25/04/2022.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let api = API()
    
    var astros = [CDAstro]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Love"
        let nib = UINib(nibName: "BookTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "BookTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        getAstroList()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewController" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let detailView = segue.destination as! DetailViewController
            print(detailView , "this is view")
            detailView.setup(data: astros[indexPath!.row])
        }  else if segue.identifier == "FavouriteViewController" {
            //             let indexPath = self.tableView.indexPathForSelectedRow
            let detailView = segue.destination as! FavouriteViewController
            print(detailView, "this is view")
            detailView.setup(data: astros.filter({ astro in
                return astro.isFavourite
            }))
        }
    }
    
    
}

// class methods
extension MainViewController {
    // TODO: read https://stackoverflow.com/questions/69464436/dont-want-to-save-data-if-it-already-exists-in-core-data
    func getAstroList() -> Void {
        //        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CDAstro")
        //        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        //        do {
        //            try context.execute(deleteRequest)
        //        } catch let _ as NSError {
        //            // TODO: handle the error
        //        }
        do {
            astros =  try context.fetch(CDAstro.fetchRequest())
            print("I got local astros:" , astros.count)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            if astros.count > 0 {
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
                    self.astros = astros.map({ astros in
                        return astros.toManagedObject(in: self.context)
                    })
                    self.tableView.reloadData()
                }
            case .failure(let error):
                debugPrint("OHOHOHOHOOHO")
                debugPrint(error)
            }
        }
    }
}

// Table view protocls
extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return astros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell") as! BookTableViewCell
        cell.setup(indexPath: indexPath, delegate: self, astro: astros[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "DetailViewController", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}


extension MainViewController : BookTableViewCellEvents {
    
    func onFavouriteButtonTapped(index: IndexPath, astro: CDAstro) {
        astros[index.row] = astro
//                tableView.reloadRows(at: [index], with: .fade)
    }
    
}
