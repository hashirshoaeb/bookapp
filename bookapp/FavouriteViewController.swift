//
//  FavouriteViewController.swift
//  bookapp
//
//  Created by Muhammad Hashir Shoaib on 28/04/2022.
//

import UIKit

class FavouriteViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var astros = [CDAstro]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favourite"
        let nib = UINib(nibName: "BookTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "BookTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    func setup(data: Array<CDAstro>) -> Void {
        astros = data
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FavouriteDetailViewController" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let detailView = segue.destination as! DetailViewController
            print(detailView , "this is view")
            detailView.setup(data: astros[indexPath!.row])
        } 
    }
    
}

// Table view protocls
extension FavouriteViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return astros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell") as! BookTableViewCell
//        cell.setup(indexPath: indexPath, delegate: self, astro: astros[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "FavouriteDetailViewController", sender: nil)
    }
}

extension FavouriteViewController  {
    
    func onFavouriteButtonTapped(index: IndexPath, astro: CDAstro) {
        astros[index.row] = astro
        //        tableView.reloadRows(at: [index], with: .fade)
    }
    
}
