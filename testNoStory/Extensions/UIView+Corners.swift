//
//  UIView+Corners.swift
//  testNoStory
//
//  Created by Andres Valerio on 11/02/23.
//

import Foundation
import UIKit

public enum ViewFeatures {
    case rounded, color(UIColor), bordered(UIColor, CGFloat), image(UIImage),
         /*roundedView(RoundedType, UIColor),*/ topRounded,
         fullRounded, customRounded(UIRectCorner)
}

public enum RoundedType {
    case full, onlyLayer
}

public struct RoundedCorners {
    
    public let radius: CGFloat
    public let corners: UIRectCorner
    
    public init(radius: CGFloat, corners: UIRectCorner) {
        self.radius = radius
        self.corners = corners
    }
}

public extension UIView {
    private static let kLayerNameGradientBorder = "GradientBorderLayer"
    
    func setup(roundedCorners: RoundedCorners) {
        setupRoundedCorners(radius: roundedCorners.radius, corners: roundedCorners.corners)
    }
    
    func setupRoundedCorners(radius: CGFloat, corners: UIRectCorner = .allCorners) {
        layer.cornerRadius = radius
        clipsToBounds = true
        if let mask = corners.mask {
            layer.maskedCorners = mask
        }
    }
    
    func makeItCircular() {
        layoutIfNeeded()
        setupRoundedCorners(radius: min(frame.size.height, frame.size.width) / 2)
    }
    
    func makeViewWith(features: [ViewFeatures]?) {
        if let features = features as [ViewFeatures]? {
            features.forEach({
                switch $0 {
                case .rounded:
                    layer.cornerRadius = 10
                    clipsToBounds = true
                case .color(let color): self.backgroundColor = color
                case .bordered(let color, let borderWidth): setCornerWith(color: color, borderWidth: borderWidth)
                case .image(let image):
                    if let imageView = self as? UIImageView { imageView.image = image }
                case .topRounded: setupRoundedCorners(radius: 10, corners: [.topLeft, .topRight])
                case .fullRounded: setupRoundedCorners(radius: 10, corners: .allCorners)
                case .customRounded(let corners): setupRoundedCorners(radius: 10, corners: corners)
                }
            })
        }
    }
    
    func setCornerWith(color: UIColor, borderWidth: CGFloat) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
    }
    
    func resetCornerRadius() {
        layer.cornerRadius = 0.0
    }
    
    func gradientBorder(width: CGFloat,
                        colors: [UIColor],
                        startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0),
                        endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0),
                        andRoundCornersWithRadius cornerRadius: CGFloat = 0) {
        
        let existingBorder = gradientBorderLayer()
        let border = existingBorder ?? CAGradientLayer()
        border.frame = CGRect(x: bounds.origin.x, y: bounds.origin.y,
                              width: bounds.size.width + width, height: bounds.size.height + width)
        border.colors = colors.map { return $0.cgColor }
        border.startPoint = startPoint
        border.endPoint = endPoint
        
        let mask = CAShapeLayer()
        let maskRect = CGRect(x: bounds.origin.x + width/2, y: bounds.origin.y + width/2,
                              width: bounds.size.width - width, height: bounds.size.height - width)
        mask.path = UIBezierPath(roundedRect: maskRect, cornerRadius: cornerRadius).cgPath
        mask.fillColor = UIColor.clear.cgColor
        mask.strokeColor = UIColor.white.cgColor
        mask.lineWidth = width
        
        border.mask = mask
        
        let exists = (existingBorder != nil)
        if !exists {
            layer.addSublayer(border)
        }
    }
    private func gradientBorderLayer() -> CAGradientLayer? {
        let borderLayers = layer.sublayers?.filter { return $0.name == UIView.kLayerNameGradientBorder }
        if borderLayers?.count ?? 0 > 1 {
            fatalError()
        }
        return borderLayers?.first as? CAGradientLayer
    }
}

extension UIRectCorner {
    var mask: CACornerMask? {
        guard self != .allCorners else { return nil }
        var cornerMask = CACornerMask()
        if contains(.topLeft) {
            cornerMask.insert(.layerMinXMinYCorner)
        }
        if contains(.topRight) {
            cornerMask.insert(.layerMaxXMinYCorner)
        }
        if contains(.bottomLeft) {
            cornerMask.insert(.layerMinXMaxYCorner)
        }
        if contains(.bottomRight) {
            cornerMask.insert(.layerMaxXMaxYCorner)
        }
        return cornerMask
    }
}

extension CACornerMask {
    var rect: UIRectCorner {
        var cornersCount = 0
        var rect = UIRectCorner()
        if contains(.layerMinXMinYCorner) {
            rect.insert(.topLeft)
            cornersCount += 1
        }
        if contains(.layerMaxXMinYCorner) {
            rect.insert(.topRight)
            cornersCount += 1
        }
        if contains(.layerMinXMaxYCorner) {
            rect.insert(.bottomLeft)
            cornersCount += 1
        }
        if contains(.layerMaxXMaxYCorner) {
            rect.insert(.bottomRight)
            cornersCount += 1
        }
        guard cornersCount != 4 else { return .allCorners }
        return rect
    }
}


