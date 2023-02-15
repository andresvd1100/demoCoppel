//
//  ExtensionUIViewController.swift
//  testNoStory
//
//  Created by Andres Valerio on 11/02/23.
//

import Foundation
import UIKit
import MKProgress
import Kingfisher

extension UIViewController{
    
    func clearCache()  {
        KingfisherManager.shared.cache.clearMemoryCache()
    }
    
    func showLoadingView() {
        MKProgress.config.activityIndicatorStyle = UIActivityIndicatorView.Style.medium
        MKProgress.config.activityIndicatorColor = .black
        MKProgress.config.preferredStatusBarStyle = .lightContent
        MKProgress.config.hudYOffset = 15.0
        MKProgress.show()
    }
    
    func configureLabel(label: UILabel, withText: String, color: UIColor, aligment: NSTextAlignment = .left, colorBack: UIColor = Style.colorSystem.neutral.white, fontSize: CGFloat = 12.0, isBold: Bool = false){
        label.textAlignment = aligment
        label.textColor = color
        label.text = withText
        label.font = label.font.withSize(fontSize)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.backgroundColor = colorBack
    }
    
    func configureTextField(textField: UITextField, placeholder: String, textColor: UIColor, radius: CGFloat = 0.0, isSecure: Bool = false){
        textField.placeholder = placeholder
        textField.textColor = textColor
        textField.setupRoundedCorners(radius: radius)
        textField.isSecureTextEntry = isSecure
    }
    
    func configureImageView(imageView: UIImageView, image: UIImage = UIImage(), radius: CGFloat = 0.0){
        imageView.image = image
        imageView.setupRoundedCorners(radius: radius)
    }
    
    func configureButton(button: UIButton,  title: String = "", image: UIImage?, backgroundColor: UIColor, radius: CGFloat = 0.0, titleColor: UIColor = Style.colorSystem.neutral.white){
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.setupRoundedCorners(radius: radius)
        if(image != nil){
            button.setImage(image, for: .normal)
        }
    }
    
    func quitBack(){
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        self.navigationItem.backButtonTitle = " "
    }
    
    @objc
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func configureTitleWithRightButtonItem(title: String, color: UIColor, aligment: NSTextAlignment, font: CGFloat = 12.0, icon: UIImage, action: Selector?, isBold: Bool = false){
        /*let appereance = UINavigationBarAppearance()
        appereance.configureWithOpaqueBackground()
        appereance.backgroundColor = Style.colorSystem.primary.blue0
        navigationController?.navigationBar.standardAppearance = appereance*/
        let lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        lblTitle.textAlignment = aligment
        lblTitle.textColor = color
        lblTitle.text = title
        lblTitle.font = UIFont.boldSystemFont(ofSize: font)
        navigationItem.titleView = lblTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: icon, style: .plain, target: self, action: action)
        navigationItem.rightBarButtonItem?.tintColor = color
    }
    
    func configureTitleCustomTypography(title: String, color: UIColor, aligment: NSTextAlignment = .center, font: CGFloat = 12.0, isBold: Bool = false){
        let lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        let attributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: color,
            .font: isBold ? UIFont.boldSystemFont(ofSize: font) : UIFont.systemFont(ofSize: font),
            .paragraphStyle: aligment
        ]
        let attS = NSAttributedString(string: title, attributes: attributes)
        lblTitle.attributedText = attS
        navigationItem.titleView = lblTitle
    }
    
    
    
    
}
