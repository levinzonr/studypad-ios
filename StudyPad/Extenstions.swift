//
//  Extenstions.swift
//  StudyPad
//
//  Created by Roman Levinzon on 12/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit

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
