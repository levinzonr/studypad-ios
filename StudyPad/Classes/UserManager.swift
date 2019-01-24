//
//  UserManager.swift
//  StudyPad
//
//  Created by Roman Levinzon on 22/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation


final class UserManager {
        
   

    var token: String? {
        get {
            return UserDefaults.standard.string(forKey: .token)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: .token)
        }
    }
    
    func isLoggedIn() -> Bool {
        return token != nil
    }
    
    func clear() {
        UserDefaults.standard.set(nil, forKey: .token)
    }
    
}

private extension String {
    static let token = "user-manager-token"
    
}
