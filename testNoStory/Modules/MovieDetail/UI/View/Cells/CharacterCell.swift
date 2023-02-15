//
//  CharacterCell.swift
//  testNoStory
//
//  Created by Andres Valerio on 14/02/23.
//

import UIKit

class CharacterCell: UICollectionViewCell {

    @IBOutlet weak var lblWork: UILabel!{
        didSet{
            configureLabel(label: lblWork, withText: "", color: Style.colorSystem.neutral.black, fontSize: 12.0)
        }
    }
    @IBOutlet weak var lblName: UILabel!{
        didSet{
            configureLabel(label: lblName, withText: "", color: Style.colorSystem.neutral.black, fontSize: 14.0, isBold: true)
        }
    }
    @IBOutlet weak var imgCharacter: UIImageView!{
        didSet{
            imgCharacter.contentMode = .scaleAspectFit
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(crew: Crew){
        lblName.text = crew.name
        lblWork.text = crew.character
        if let url = URL(string: crew.imagePath ?? "") {
            imgCharacter.loadImage(url: url, placeholder: Style.iconCatalog.cast)
        }
        
    }

}
