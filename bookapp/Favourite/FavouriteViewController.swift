//
//  FavouriteViewController.swift
//  bookapp
//
//  Created by Muhammad Hashir Shoaib on 28/04/2022.
//

import UIKit

protocol FavouriteDisplayLogic {
    func updateTable(astros: [CDAstro])
    func updateRow(at: IndexPath)
}

class FavouriteViewController: UIViewController, ViewSetup,  FavouriteDisplayLogic {
    // MARK: - VIP setup
    
    var interactor: FavouriteBusinessLogic!
    var router: (FavouriteRoutingLogic & FavouriteDataPassing)!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        let viewController = self
        let presenter = FavouritePresenter(viewController: viewController)
        let interactor = FavouriteInteractor(presenter: presenter)
        let router = FavouriteRouter(viewController: viewController, dataStore: interactor)
        viewController.interactor = interactor
        viewController.router = router
    }
    
    // MARK: - View
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favourite"
        let nib = UINib(nibName: "BookTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "BookTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FavouriteDetailViewController" {
            router.routeToDetailScreen(segue: segue)
        } 
    }
    
    
    func updateTable(astros: [CDAstro]) {
        tableView.reloadData()
    }
    
    func updateRow(at: IndexPath) {
        tableView.reloadRows(at: [at], with: .fade)
    }
    
}

// Table view protocls
extension FavouriteViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.astroCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell") as! BookTableViewCell
        cell.setup(indexPath: indexPath, astro: interactor.getAstro(indexPath: indexPath), onFavouriteButtonTapped: onFavouriteButtonTapped)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.setSelectedAstro(index: indexPath)
        self.performSegue(withIdentifier: "FavouriteDetailViewController", sender: nil)
    }
    
    func onFavouriteButtonTapped(index: IndexPath, astro: CDAstro) {
        if astro.isFavourite {
            interactor.markUnFavourite(indexPath: index)
        } else {
            interactor.markFavourite(indexPath: index)
        }
    }
}


