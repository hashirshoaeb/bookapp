//
//  BookTableViewCell.swift
//  bookapp
//
//  Created by Muhammad Hashir Shoaib on 25/04/2022.
//

import UIKit

typealias HeartTapped = (_ indexPath: IndexPath, _ astro: CDAstro) -> ()

class BookTableViewCell: UITableViewCell {
    
    let favouriteIcon = "heart.fill"
    let unfavoutieIcon = "heart"
    
    var astro : CDAstro?
    var indexPath : IndexPath?
    var onFavouriteButtonTapped: HeartTapped?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - View
    @IBOutlet weak var bookLabelView: UILabel!
    @IBOutlet weak var favouriteIconButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(indexPath: IndexPath, astro: CDAstro, onFavouriteButtonTapped: @escaping HeartTapped) {
        self.astro = astro
        self.indexPath = indexPath
        self.bookLabelView.text = astro.title
        self.onFavouriteButtonTapped = onFavouriteButtonTapped
        setFavouriteIcon(astro.isFavourite)
    }
    
    func setFavouriteIcon(_ isFavourite : Bool) {
        if isFavourite {
            favouriteIconButton.setImage(UIImage(systemName: favouriteIcon), for: .normal)
        } else {
            favouriteIconButton.setImage(UIImage(systemName: unfavoutieIcon), for: .normal)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func onFavouriteIconTapped(_ sender: UIButton) {
        // astro!.toggleFavourite(in: context)
//        setFavouriteIcon(astro!.isFavourite)
        onFavouriteButtonTapped?(indexPath!, astro!)
    }
    
    
}
