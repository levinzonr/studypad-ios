//
//  Extenstions.swift
//  StudyPad
//
//  Created by Roman Levinzon on 12/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension Array where Element: Equatable {
    
    @discardableResult mutating func remove(object: Element) -> Bool {
        if let index = index(of: object) {
            self.remove(at: index)
            return true
        }
        return false
    }
    
    @discardableResult mutating func remove(where predicate: (Array.Iterator.Element) -> Bool) -> Bool {
        if let index = self.index(where: { (element) -> Bool in
            return predicate(element)
        }) {
            self.remove(at: index)
            return true
        }
        return false
    }
    
}

extension String  {
    
    func instantiateViewController() -> UIViewController {
        let sb = UIStoryboard.init(name: self, bundle: nil)
        return sb.instantiateViewController(withIdentifier: self)
    }
    
}

extension UIViewController {
    static func instantiate() -> UIViewController {
        let name = NSStringFromClass(self)
        let sb = UIStoryboard.init(name: name, bundle: nil)
        return sb.instantiateViewController(withIdentifier: name)
    }
}

extension Request {
    public func debugLog() -> Self {
        #if DEBUG
        debugPrint(self)
        #endif
        return self
    }
}

extension UIActivityIndicatorView {
    
    var visible: Bool {
        
        get {return !self.isHidden}
        
        set {
            isHidden = !newValue
            if (newValue) {
                startAnimating()
            } else {
                stopAnimating()
            }
        }
        
    }
    
}


extension UICollectionViewCell {
    static var reuseId: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: reuseId, bundle: .main)
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
