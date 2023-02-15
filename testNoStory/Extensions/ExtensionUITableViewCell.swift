//
//  ExtensionUITableViewCell.swift
//  testNoStory
//
//  Created by Andres Valerio on 14/02/23.
//

import Foundation
import UIKit

extension UITableViewCell{
    func configureLabel(label: UILabel, withText: String, color: UIColor, fontSize: CGFloat, aligment: NSTextAlignment = .left, isBold: Bool = false){
        let attributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: color,
            .font: isBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize),
            .paragraphStyle: aligment
        ]
        let attS = NSAttributedString(string: withText, attributes: attributes)
        label.attributedText = attS
        label.textAlignment = aligment
        label.textColor = color
        label.font = label.font.withSize(fontSize)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.baselineAdjustment = .alignCenters
        label.contentMode = .topLeft
        label.numberOfLines = 0
    }
    
    func configureImageView(imageView: UIImageView, image: UIImage = UIImage(), radius: CGFloat = 0.0){
        imageView.image = image
        imageView.setupRoundedCorners(radius: radius)
    }
    
    func configureButton(button: UIButton,  title: String = "", image: UIImage?, backgroundColor: UIColor, radius: CGFloat = 0.0){
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        button.setupRoundedCorners(radius: radius)
        if(image != nil){
            button.setImage(image, for: .normal)
        }
    }
}
