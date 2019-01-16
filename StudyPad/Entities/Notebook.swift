//
//  Notebook.swift
//  StudyPad
//
//  Created by Roman Levinzon on 12/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit

struct Notebook : Codable {
    var id: Int
    var name: String
    var notesCount : Int
    var gradientColor: GradientColor
}


struct GradientColor : Codable {
    var firstColor: String
    var secondColor: String
    
    func toColorArray() -> [CGColor] {
        var array = Array<CGColor>()
        array.append(hexStringToUIColor(hex: firstColor).cgColor)
        array.append(hexStringToUIColor(hex: secondColor).cgColor)
        return array
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
