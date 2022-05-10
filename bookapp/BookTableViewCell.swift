//
//  BookTableViewCell.swift
//  bookapp
//
//  Created by Muhammad Hashir Shoaib on 25/04/2022.
//

import UIKit

protocol BookTableViewCellEvents {
    func onFavouriteButtonTapped(index : IndexPath , astro : CDAstro)
}

class BookTableViewCell: UITableViewCell {
    
    let favouriteIcon = "heart.fill"
    let unfavoutieIcon = "heart"
    var isFavourite = false
    var astro : CDAstro?
    var indexPath : IndexPath?
    var delegate : BookTableViewCellEvents?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var bookLabelView: UILabel!
    @IBOutlet weak var favouriteIconButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isFavourite = false
    }
    
    func setup(indexPath: IndexPath, delegate: BookTableViewCellEvents, astro: CDAstro) {
        self.delegate = delegate
        self.astro = astro
        self.indexPath = indexPath
        self.bookLabelView.text = astro.title
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
        // Configure the view for the selected state
    }
    
    @IBAction func onFavouriteIconTapped(_ sender: UIButton) {
        astro!.toggleFavourite(in: context)
        setFavouriteIcon(astro!.isFavourite)
        delegate!.onFavouriteButtonTapped(index: indexPath!, astro: astro!)
    }
    
    
}
