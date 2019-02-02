//
//  GradientView.swift
//  StudyPad
//
//  Created by Roman Levinzon on 02/02/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation

import UIKit

final class GradientView: UIView {
    
    // MARK: - Static
    
    override static var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    // MARK: - Properties
    
    var colors: [CGColor] = GradientColor(startColor: "#FFFF", endColor: "#FFFF").toColorArray() {
        didSet {
            setNeedsLayout()
        }
    }
    
    private lazy var gradientLayer = layer as! CAGradientLayer
    
    // MARK: - Init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Setup gradient
        gradientLayer.masksToBounds = true
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
    }
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.colors = colors
        roundCorners(corners: [.topLeft, .bottomLeft], radius: 8)
    }
}
