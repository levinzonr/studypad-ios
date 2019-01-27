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
    
    var userInfo: User? {
        get {
            
            let data = UserDefaults.standard.data(forKey: .userInfo) ?? Data()
            return (try? JSONDecoder().decode(User.self, from: data))
        }
        
        set {
            print("newVale \(newValue)")
            let string = (try? JSONEncoder().encode(newValue)) ?? Data()
            UserDefaults.standard.set(string, forKey: .userInfo)
        }
    }
    
    func isLoggedIn() -> Bool {
        return token != nil
    }
    
    func clear() {
        UserDefaults.standard.set(nil, forKey: .token)
        UserDefaults.standard.removeObject(forKey: .userInfo)
    }
    
}

private extension String {
    static let token = "user-manager-token"
    static let userInfo = "user-manger-info"
    
}
