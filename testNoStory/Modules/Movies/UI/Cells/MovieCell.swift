//
//  MovieCell.swift
//  testNoStory
//
//  Created by Andres Valerio on 13/02/23.
//

import UIKit
import TMDBSwift

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var imgMovie: UIImageView!{
        didSet{
            configureImageView(imageView: imgMovie, radius: 10.0)
            imgMovie.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var imgRated: UIImageView!{
        didSet{
            configureImageView(imageView: imgRated, image: Style.iconCatalog.rated)
        }
    }
    @IBOutlet weak var lblName: UILabel!{
        didSet{
            configureLabel(label: lblName, withText: "", color: Style.colorSystem.primary.green0, fontSize: 9.0)
        }
    }
    @IBOutlet weak var lblDate: UILabel!{
        didSet{
            configureLabel(label: lblDate, withText: "", color: Style.colorSystem.primary.green0, fontSize: 8.0)
        }
    }
    @IBOutlet weak var lblRated: UILabel!{
        didSet{
            configureLabel(label: lblRated, withText: "", color: Style.colorSystem.primary.green0, fontSize: 8.0, aligment: .center)
        }
    }
    @IBOutlet weak var lblDesc: UILabel!{
        didSet{
            configureLabel(label: lblDesc, withText: "", color: Style.colorSystem.neutral.white, fontSize: 6.0)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(movie: Movie){
        self.contentView.backgroundColor = Style.colorSystem.primary.blue0
        lblDesc.text = movie.overview
        lblDate.text = movie.releaseDate
        lblName.text = movie.title
        lblRated.text = "\(movie.popularity ?? 0.0)"
        if let url = URL(string: movie.posterPath ?? "") {
            imgMovie.loadImage(url: url, placeholder: UIImage())
        }
        
    }

}
