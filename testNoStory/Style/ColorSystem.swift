//
//  ColorSystem.swift
//  testNoStory
//
//  Created by Andres Valerio on 11/02/23.
//

import Foundation
import UIKit

struct ColorSystem {
    let primary = PrimaryColor()
    let secondary = SecondaryColor()
    let neutral = NeutralColor()
}

struct PrimaryColor {
    let green0 = UIColor.getColor(from: "#1CD060")
    let blue0 = UIColor.getColor(from: "#0C171E")
}

struct SecondaryColor {
    let error = UIColor.getColor(from: "#CE1126")
    let danger = UIColor.getColor(from: "#B63228")
    let warning = UIColor.getColor(from: "#F3DF24")
    let information = UIColor.getColor(from: "#0DB9EF")
    let success = UIColor.getColor(from: "#8FCB7A")
}

struct NeutralColor {
    let gray0 = UIColor.getColor(from: "#000000")
    let gray1 = UIColor.getColor(from: "#292929")
    let gray2 = UIColor.getColor(from: "#3C3C3E")
    let gray3 = UIColor.getColor(from: "#646464")
    let gray4 = UIColor.getColor(from: "#8B8989")
    let gray5 = UIColor.getColor(from: "#DADADA")
    let gray6 = UIColor.getColor(from: "#EBECED")
    let gray7 = UIColor.getColor(from: "#F5F5F5")
    let gray8 = UIColor.getColor(from: "#FAFAFA")
    let white = UIColor.getColor(from: "#FFFFFF")
    let black = UIColor.getColor(from: "#000000")
    let transparent = UIColor.getColor(from: "000000", with: 0.0)
}

