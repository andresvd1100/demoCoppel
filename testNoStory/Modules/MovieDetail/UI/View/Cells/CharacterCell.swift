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
            configureLabel(label: lblWork, withText: "", color: Style.colorSystem.primary.green0, fontSize: 10.0, aligment: .center)
        }
    }
    @IBOutlet weak var lblName: UILabel!{
        didSet{
            configureLabel(label: lblName, withText: "", color: Style.colorSystem.neutral.gray2, fontSize: 12.0,aligment: .center, isBold: true)
        }
    }
    @IBOutlet weak var imgCharacter: UIImageView!{
        didSet{
            imgCharacter.contentMode = .scaleAspectFit
            imgCharacter.setupRoundedCorners(radius: 5.0)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(crew: Crew){
        self.contentView.backgroundColor = Style.colorSystem.neutral.white
        self.contentView.setupRoundedCorners(radius: 5.0)
        lblName.text = crew.name
        lblWork.text = crew.character
        if let url = URL(string: crew.imagePath ?? "") {
            imgCharacter.loadImage(url: url, placeholder: Style.iconCatalog.cast)
        }
        
    }

}
