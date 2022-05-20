//
//  DetailViewController.swift
//  bookapp
//
//  Created by Muhammad Hashir Shoaib on 25/04/2022.
//

import UIKit

class DetailViewController: UIViewController, ViewSetup, DetailDataStore {
    
    // MARK: - VIP setup
    
    var router: (DetailDataPassing)!
    
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
        let router = DetailRouter(viewController: viewController, dataStore: self)
        viewController.router = router
    }
    
    // MARK: - DataStore
    
    var data: CDAstro?
    
    // MARK: - View
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = data?.title
        self.descriptionTextView.text = data?.explanation
        self.navigationItem.largeTitleDisplayMode = .never
        DispatchQueue.global().async {
            self.backgroundImageView.loadFrom(URLAddress: self.data?.url ?? "")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    @IBAction func onShareTapped(_ sender: UIBarButtonItem) {
        let activityViewController = UIActivityViewController(activityItems: [self.descriptionTextView.text!, self.backgroundImageView.image!], applicationActivities: nil)
        self.present(activityViewController, animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

// https://www.codingem.com/swift-load-image-from-url/
extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        guard let imageData = try? Data(contentsOf: url) else {
            return
        }
        guard let loadedImage = UIImage(data: imageData) else {
            return
        }
        DispatchQueue.main.async { [weak self] in
                self?.image = loadedImage
        }
    }
}
