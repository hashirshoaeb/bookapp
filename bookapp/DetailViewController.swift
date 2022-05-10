//
//  DetailViewController.swift
//  bookapp
//
//  Created by Muhammad Hashir Shoaib on 25/04/2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var data : CDAstro?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = data?.title
        //        self.navigationItem.titleView?.tintColor = .blue
        //        self.navigationController?.navigationBar.tintColor = .blues
        self.descriptionTextView.text = data?.explanation
        self.navigationItem.largeTitleDisplayMode = .never
        
        DispatchQueue.global().async {
            self.backgroundImageView.loadFrom(URLAddress: self.data?.url ?? "")
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

//    deinit {
//        print("HYAAAA OOD RABBBAAA")
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//    }
    
    // setup the UI on naviagation
    func setup(data : CDAstro) {
        self.data = data
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
