//
//  Utils.swift
//  testNoStory
//
//  Created by Andres Valerio on 13/02/23.
//

import Foundation
import UIKit

class Utils{
    static func changeRootViewControllerWith(controller: UIViewController) {
        guard let window = UIApplication.shared.delegate?.window else { return }
        let transition = UIView.AnimationOptions.transitionFlipFromLeft
        UIView.transition(with: window ?? UIWindow(),
                          duration: 0.5,
                          options: transition,
                          animations: {
            UIApplication.shared.delegate?.window??.rootViewController = controller
        }, completion: nil)
    }
    
    static func showAlertWith(message: String, completionView: @escaping () -> Void) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "Aceptar", style: .default)
        alert.addAction(acceptAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: completionView)
    }
}
