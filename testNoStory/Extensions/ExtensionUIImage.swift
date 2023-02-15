//
//  ExtensionUIImage.swift
//  testNoStory
//
//  Created by Andres Valerio on 13/02/23.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView{
    
    func loadImage(url: URL?, placeholder: UIImage?){
        guard let url = url else {
            self.kf.setImage(with: url, placeholder: placeholder)
            return
        }
        let cache = ImageCache.default
        if cache.isCached(forKey: url.absoluteString) {
            cache.retrieveImage(forKey: url.absoluteString) { result in
                switch result {
                case .success(let imgResult):
                    self.image = imgResult.image
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
        } else {
            let resource = ImageResource(downloadURL: url, cacheKey: url.absoluteString)
            self.kf.setImage(with: resource, placeholder: placeholder)
        }
    }
}
