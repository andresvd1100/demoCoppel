//
//  IconCatalog.swift
//  testNoStory
//
//  Created by Andres Valerio on 11/02/23.
//

import Foundation
import UIKit

struct IconCatalog {
    var icon: UIImage { UIImage(named: "icon") ?? UIImage() }
    var background: UIImage { UIImage(named: "background") ?? UIImage() }
    var rated: UIImage { UIImage(named: "rated") ?? UIImage() }
    var menu: UIImage { UIImage(named: "menu") ?? UIImage() }
    var cast: UIImage { UIImage(named: "cast") ?? UIImage() }
    var profile: UIImage { UIImage(named: "profile") ?? UIImage() }
}
