//
//  MainViewController.swift
//  bookapp
//
//  Created by Muhammad Hashir Shoaib on 25/04/2022.
//

import UIKit
import CoreData

enum Home {
    enum fetchAstroList {
        struct Request{}
        struct Response{}
        struct ViewModel{}
    }
}

protocol ViewSetup {
    func setup()
}

protocol HomeDisplayLogic {
    func updateTable(astros: [CDAstro])
    func updateRow(at: IndexPath)
}


class HomeViewController: UIViewController, ViewSetup, HomeDisplayLogic {
    // MARK: - VIP setup
    
    var interactor: HomeBusinessLogic!
    var router: (HomeRoutingLogic & HomeDataPassing)!
    
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
        let presenter = HomePresenter(viewController: viewController)
        let interactor = HomeInteractor(presenter: presenter)
        let router = HomeRouter(viewController: viewController, dataStore: interactor)
        viewController.interactor = interactor
        viewController.router = router
        
    }
    
    // MARK: - View
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Love"
        let nib = UINib(nibName: "BookTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "BookTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        loadAstros()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewController" {
            router?.routeToDetailScreen(segue: segue)
            // detailView.setup(data: astros[indexPath!.row])
        }  else if segue.identifier == "FavouriteViewController" {
            router.routeToFavouriteScreen(segue: segue)
        }
    }
    
    func updateTable(astros: [CDAstro]) {
        tableView.reloadData()
    }
    
    func updateRow(at: IndexPath) {
        tableView.reloadRows(at: [at], with: .fade)
    }
    
    // MARK: - Events
    
    func loadAstros() {
        interactor?.fetchAstros(request: Home.fetchAstroList.Request())
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor!.astroCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell") as! BookTableViewCell
        cell.setup(indexPath: indexPath, astro: interactor.getAstro(indexPath: indexPath), onFavouriteButtonTapped: onFavouriteButtonTapped)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.setSelectedAstro(index: indexPath)
        self.performSegue(withIdentifier: "DetailViewController", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func onFavouriteButtonTapped(index: IndexPath, astro: CDAstro) {
        if astro.isFavourite {
            interactor.markUnFavourite(indexPath: index)
        } else {
            interactor.markFavourite(indexPath: index)
        }
    }
}
